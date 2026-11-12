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
-- 6. TABEL: literacy_tips (Tips Literasi di Beranda - Poin #1)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.literacy_tips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    tip_number VARCHAR(50) NOT NULL DEFAULT 'Tips',
    icon_name VARCHAR(50) NOT NULL DEFAULT 'fact_check',
    icon_bg_hex VARCHAR(20) DEFAULT '#D1FAE5',
    icon_color_hex VARCHAR(20) DEFAULT '#059669',
    category VARCHAR(50) DEFAULT 'Umum',
    order_index INT DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.literacy_tips ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view active tips" ON public.literacy_tips;
CREATE POLICY "Anyone can view active tips" 
ON public.literacy_tips FOR SELECT 
USING (is_active = true);

-- Data Awal (Seed Data) Tips Literasi
INSERT INTO public.literacy_tips (title, description, tip_number, icon_name, icon_bg_hex, icon_color_hex, order_index)
VALUES 
    (
        'Periksa sumber informasi',
        'Pastikan diterbitkan oleh portal berita resmi yang terverifikasi dan terdaftar di Dewan Pers.',
        'Tips #1',
        'fact_check',
        '#D1FAE5',
        '#059669',
        1
    ),
    (
        'Waspada judul',
        'Jangan langsung percaya judul berita yang bombastis dan clickbait yang memicu emosi.',
        'Tips #2',
        'campaign',
        '#FFE4E6',
        '#E11D48',
        2
    ),
    (
        'Cek Tanggal & Konteks',
        'Periksa tanggal rilis artikel untuk memastikan berita bukan daur ulang lama yang dipelintir.',
        'Tips #3',
        'date_range',
        '#E0F2FE',
        '#0284C7',
        3
    )
ON CONFLICT DO NOTHING;


-- ==============================================================================
-- 7. TABEL: guide_principles & guide_contents (Panduan Literasi - Poin #2)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.guide_principles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    step_number VARCHAR(10) NOT NULL DEFAULT '1',
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    sub_points JSONB DEFAULT '[]'::jsonb,
    order_index INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.guide_principles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view guide principles" ON public.guide_principles;
CREATE POLICY "Anyone can view guide principles" 
ON public.guide_principles FOR SELECT 
USING (true);

-- Seed Data Prinsip Panduan
INSERT INTO public.guide_principles (step_number, title, description, sub_points, order_index)
VALUES 
    (
        '1',
        'Prinsip Uji Informasi (Check & Recheck)',
        'Karya jurnalistik profesional dan komunikasi publik yang bertanggung jawab selalu memverifikasi kebenaran materi sebelum disebarkan kepada khalayak umum.',
        '[
            {"icon": "business", "text": "Menghubungi pihak berwenang atau narasumber primer secara langsung untuk konfirmasi keabsahan pernyataan."},
            {"icon": "warning", "text": "Menghindari sensasionalisme atau konten provokatif tanpa menyertakan bukti material yang teruji."},
            {"icon": "insights", "text": "Melakukan penelusuran ulang terhadap klaim statistik dan konteks waktu saat dokumen tersebut diterbitkan."}
        ]'::jsonb,
        1
    ),
    (
        '2',
        'Ciri Berita Memenuhi Standar Verifikasi',
        'Saat membaca laporan berita atau tilikan informasi, cermati elemen akuntabilitas redaksional berikut:',
        '[
            {"icon": "person", "text": "Transparansi Penulis: Mencantumkan nama jurnalis dan susunan dewan redaksi yang jelas serta dapat ditelusuri rekam jejaknya."},
            {"icon": "link", "text": "Rujukan Terbuka: Tautan atau lampiran dokumen resmi disertakan secara transparan dan bukan sekadar tangkapan layar terpotong."},
            {"icon": "update", "text": "Pengakuan Keterbukaan: Secara jujur mengakui batasan informasi apabila konfirmasi dari pihak terkait masih berjalan."}
        ]'::jsonb,
        2
    )
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS public.guide_contents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    quote_text TEXT NOT NULL,
    checklist_title TEXT NOT NULL DEFAULT 'Hal yang Perlu Diperhatikan',
    checklist_subtitle TEXT NOT NULL,
    checklist_items JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.guide_contents ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view guide contents" ON public.guide_contents;
CREATE POLICY "Anyone can view guide contents" 
ON public.guide_contents FOR SELECT 
USING (true);

-- Seed Data Konten Checklist & Kutipan
INSERT INTO public.guide_contents (quote_text, checklist_title, checklist_subtitle, checklist_items)
VALUES (
    'Berita yang kredibel dibangun atas fakta yang telah diuji ulang (cross-checked) ke sumber primer yang berwenang, bukan sekadar kutipan anonim atau rumor viral di lini masa.',
    'Hal yang Perlu Diperhatikan',
    'Gunakan daftar periksa klaim ini sebelum membagikan ulang kabar ke grup percakapan atau media sosial.',
    '[
        "Apakah berita mengutip sumber pertama yang kompeten dan kredibel?",
        "Apakah ada bukti dokumen, rekaman utuh, atau data penunjang resmi?",
        "Jika masih meragukan, uji teks klaim ke HoaxCheck sebelum disebarkan."
    ]'::jsonb
)
ON CONFLICT DO NOTHING;


-- ==============================================================================
-- 8. TABEL: app_info (Tentang HoaxCheck, Visi, Cara Kerja - Poin #3)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.app_info (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    app_name VARCHAR(100) NOT NULL DEFAULT 'HoaxCheck',
    tagline TEXT NOT NULL,
    header_description TEXT NOT NULL,
    about_description TEXT NOT NULL,
    pills JSONB DEFAULT '["Deteksi < 3 Detik", "Fokus Bahasa Indonesia"]'::jsonb,
    steps JSONB DEFAULT '[]'::jsonb,
    disclaimer_text TEXT NOT NULL,
    app_version VARCHAR(50) DEFAULT 'HoaxCheck v1.0.0',
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.app_info ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view app info" ON public.app_info;
CREATE POLICY "Anyone can view app info" 
ON public.app_info FOR SELECT 
USING (true);

-- Seed Data Tentang HoaxCheck
INSERT INTO public.app_info (app_name, tagline, header_description, about_description, pills, steps, disclaimer_text, app_version)
VALUES (
    'HoaxCheck',
    'Bantu Kenali Informasi yang Meragukan',
    'HoaxCheck adalah aplikasi yang membantu pengguna mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui analisis teks berbasis Machine Learning.',
    'Dirancang khusus untuk ekosistem literasi digital nusantara, HoaxCheck memadai struktur semantik, nuansa provokatif, serta konsistensi sintaksis pesan viral guna memetakan kemungkinan misinformasi secara objektif dalam hitungan detik.',
    '["Deteksi < 3 Detik", "Fokus Bahasa Indonesia"]'::jsonb,
    '[
        {
            "number": "01",
            "icon": "edit_note",
            "title": "Masukkan Teks",
            "description": "Masukkan atau tempel paragraf informasi, pesan berantai, atau kutipan berita yang ingin diperiksa."
        },
        {
            "number": "02",
            "icon": "psychology",
            "title": "Analisis Linguistik AI",
            "description": "Sistem menganalisis pola kalimat, sentimen ekstrim, dan karakteristik disinformasi menggunakan model Machine Learning terlatih."
        },
        {
            "number": "03",
            "icon": "fact_check",
            "title": "Hasil & Skor Kepercayaan",
            "description": "HoaxCheck menampilkan hasil indikasi beserta persentase confidence score secara lugas dan transparan."
        }
    ]'::jsonb,
    'HoaxCheck merupakan alat bantu deteksi awal dan bukan alat fact-checking resmi lembaga pers. Hasil yang diberikan merupakan prediksi probabilistik model kecerdasan buatan dan tetap perlu diverifikasi ulang melalui portal berita bersertifikat Dewan Pers.',
    'HoaxCheck v1.0.0'
)
ON CONFLICT DO NOTHING;

