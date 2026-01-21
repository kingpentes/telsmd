class ResultModel {
  final String keterangan;
  final String kesimpulan;
  final String tindakLanjut;
  final String petugasPemeriksa;

  ResultModel({
    required this.keterangan,
    required this.kesimpulan,
    required this.tindakLanjut,
    required this.petugasPemeriksa,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      keterangan: json['keterangan'] ?? '',
      kesimpulan: json['kesimpulan'] ?? '',
      tindakLanjut: json['tindaklanjut'] ?? '',
      petugasPemeriksa: json['petugas_pemeriksa'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keterangan': keterangan,
      'kesimpulan': kesimpulan,
      'tindaklanjut': tindakLanjut,
      'petugas_pemeriksa': petugasPemeriksa,
    };
  }
}
