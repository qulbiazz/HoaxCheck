/// Kelas dasar Failure untuk menangani error dalam Clean Architecture
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Terjadi kesalahan pada server.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Gagal melakukan autentikasi.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Gagal memuat data lokal.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Tidak ada koneksi internet.']);
}
