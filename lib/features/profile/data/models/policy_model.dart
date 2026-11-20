class PolicyModel {
  final String id;
  final String type;
  final String title;
  final String content;
  final DateTime? updatedAt;

  PolicyModel({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    this.updatedAt,
  });

  /// Fungsi untuk mengubah data dari Supabase (bentuknya Map/JSON) 
  /// menjadi objek PolicyModel yang bisa dibaca Flutter.
  factory PolicyModel.fromMap(Map<String, dynamic> map) {
    return PolicyModel(
      id: map['id']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      updatedAt: map['updated_at'] != null 
          ? DateTime.tryParse(map['updated_at'].toString()) 
          : null,
    );
  }

  /// Fungsi untuk mengubah objek PolicyModel kembali menjadi Map (JSON).
  /// Ini berguna kalau nanti kita mau menyimpan/mengupdate data ke Supabase.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'content': content,
    };
  }
}