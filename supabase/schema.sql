-- ==============================================================================
-- HOAXCHECK APP - SUPABASE DATABASE SCHEMA & MIGRATIONS
-- Jalankan skrip ini pada Supabase Dashboard > SQL Editor
-- ==============================================================================

-- 1. TABEL: user_histories (Riwayat Pemeriksaan Hoaks)
CREATE TABLE IF NOT EXISTS public.user_histories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    snippet TEXT NOT NULL,
    is_hoax BOOLEAN NOT NULL DEFAULT false,
    confidence_str VARCHAR(20) NOT NULL DEFAULT '0%',
    classification VARCHAR(100) NOT NULL DEFAULT 'Machine Learning',
    source VARCHAR(100) DEFAULT 'Cloud DB',
    tested_at TIMESTAMPTZ DEFAULT NOW()
);

-- Pastikan kolom user_id tersedia jika tabel sudah terbuat sebelumnya tanpa user_id
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_schema = 'public' 
          AND table_name = 'user_histories' 
          AND column_name = 'user_id'
    ) THEN
        ALTER TABLE public.user_histories 
        ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Row Level Security (RLS) untuk user_histories
ALTER TABLE public.user_histories ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view their own histories" ON public.user_histories;
CREATE POLICY "Users can view their own histories" 
ON public.user_histories
FOR SELECT 
USING (auth.uid() = user_id OR user_id IS NULL);

DROP POLICY IF EXISTS "Users can insert their own histories" ON public.user_histories;
CREATE POLICY "Users can insert their own histories" 
ON public.user_histories
FOR INSERT 
WITH CHECK (auth.uid() = user_id OR user_id IS NULL);

DROP POLICY IF EXISTS "Users can delete their own histories" ON public.user_histories;
CREATE POLICY "Users can delete their own histories" 
ON public.user_histories
FOR DELETE 
USING (auth.uid() = user_id OR user_id IS NULL);


-- ==============================================================================
-- 2. TABEL: problem_reports (Laporan Masalah / Bug dari Halaman Profil)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.problem_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT NOT NULL,
    email VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Menunggu Review',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.problem_reports ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can insert problem reports" ON public.problem_reports;
CREATE POLICY "Anyone can insert problem reports" 
ON public.problem_reports
FOR INSERT 
WITH CHECK (true);

DROP POLICY IF EXISTS "Users can view their own problem reports" ON public.problem_reports;
CREATE POLICY "Users can view their own problem reports" 
ON public.problem_reports
FOR SELECT 
USING (auth.uid() = user_id);


-- ==============================================================================
-- 3. TABEL: notifications (Pusat Notifikasi Pengguna)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    time_label VARCHAR(50) DEFAULT 'Baru saja',
    tag_label VARCHAR(50) DEFAULT 'Info',
    is_unread BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view their own notifications" ON public.notifications;
CREATE POLICY "Users can view their own notifications" 
ON public.notifications
FOR SELECT 
USING (auth.uid() = user_id OR user_id IS NULL);

DROP POLICY IF EXISTS "Anyone can insert notifications" ON public.notifications;
CREATE POLICY "Anyone can insert notifications" 
ON public.notifications
FOR INSERT 
WITH CHECK (true);

DROP POLICY IF EXISTS "Users can update their notifications" ON public.notifications;
CREATE POLICY "Users can update their notifications" 
ON public.notifications
FOR UPDATE 
USING (auth.uid() = user_id OR user_id IS NULL);


-- ==============================================================================
-- 4. TABEL: profiles (Profil Pengguna Terhubung Otomatis dengan Auth)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
CREATE POLICY "Profiles are viewable by everyone" 
ON public.profiles FOR SELECT 
USING (true);

DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
CREATE POLICY "Users can update their own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can insert their own profile" ON public.profiles;
CREATE POLICY "Users can insert their own profile" 
ON public.profiles FOR INSERT 
WITH CHECK (auth.uid() = id);

-- Trigger untuk sinkronisasi otomatis pendaftaran akun auth.users -> profiles
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'Pengguna Baru'),
    NEW.raw_user_meta_data->>'avatar_url'
  )
  ON CONFLICT (id) DO UPDATE
  SET full_name = EXCLUDED.full_name;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- ==============================================================================
-- 5. STORAGE BUCKET: avatars (Penyimpanan Foto Profil Pengguna)
-- ==============================================================================
INSERT INTO storage.buckets (id, name, public) 
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Kebijakan Akses Storage:
-- a. Publik dapat melihat foto profil (avatar)
DROP POLICY IF EXISTS "Public Avatar Access" ON storage.objects;
CREATE POLICY "Public Avatar Access" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'avatars');

-- b. Pengguna terautentikasi dapat mengunggah foto profil
DROP POLICY IF EXISTS "Authenticated users can upload avatars" ON storage.objects;
CREATE POLICY "Authenticated users can upload avatars" 
ON storage.objects FOR INSERT 
TO authenticated 
WITH CHECK (bucket_id = 'avatars');

-- c. Pengguna terautentikasi dapat memperbarui foto profil mereka
DROP POLICY IF EXISTS "Authenticated users can update their avatars" ON storage.objects;
CREATE POLICY "Authenticated users can update their avatars" 
ON storage.objects FOR UPDATE 
TO authenticated 
USING (bucket_id = 'avatars');

-- d. Pengguna terautentikasi dapat menghapus foto profil mereka
DROP POLICY IF EXISTS "Authenticated users can delete their avatars" ON storage.objects;
CREATE POLICY "Authenticated users can delete their avatars" 
ON storage.objects FOR DELETE 
TO authenticated 
USING (bucket_id = 'avatars');


-- ==============================================================================
-- 6. TABEL: app_policies (Kebijakan Privasi & Syarat Ketentuan)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.app_policies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(50) NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.app_policies ENABLE ROW LEVEL SECURITY;

-- Semua orang (termasuk yang belum login) boleh membaca kebijakan
DROP POLICY IF EXISTS "Anyone can read app policies" ON public.app_policies;
CREATE POLICY "Anyone can read app policies" 
ON public.app_policies
FOR SELECT 
USING (true);

-- Hanya sistem/admin yang bisa insert/update (opsional, buat jaga-jaga)
DROP POLICY IF EXISTS "Authenticated users can manage app policies" ON public.app_policies;
CREATE POLICY "Authenticated users can manage app policies" 
ON public.app_policies
FOR ALL 
TO authenticated 
USING (true);