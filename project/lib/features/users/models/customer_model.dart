class CustomerModel {
  final BigInt idPel;
  final BigInt unitUp;
  final String nama;
  final String alamat;
  final String tarif;
  final double daya;
  final String merkMeter;
  final String noMeter;
  final double tahunMeter;
  final double faktorKaliMeter;

  CustomerModel({
    required this.idPel,
    required this.unitUp,
    required this.nama,
    required this.alamat,
    required this.tarif,
    required this.daya,
    required this.merkMeter,
    required this.noMeter,
    required this.tahunMeter,
    required this.faktorKaliMeter,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idPel: json['idpel_id'] != null
          ? BigInt.tryParse(json['idpel_id'].toString()) ?? BigInt.zero
          : BigInt.zero,
      unitUp: json['unit_input_id'] != null
          ? BigInt.tryParse(json['unit_input_id'].toString()) ?? BigInt.zero
          : BigInt.zero,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      tarif: json['tarif'] ?? '',
      daya: json['daya'] != null
          ? double.tryParse(json['daya'].toString()) ?? 0.0
          : 0.0,
      merkMeter: json['merk_meter'] ?? '',
      noMeter: json['nomormeter'] ?? '',
      tahunMeter: json['tahunmeter'] != null
          ? double.tryParse(json['tahunmeter'].toString()) ?? 0.0
          : 0.0,
      faktorKaliMeter: json['fxm'] != null
          ? double.tryParse(json['fxm'].toString()) ?? 0.0
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpel_id': idPel.toString(),
      'unit_input_id': unitUp.toString(),
      'nama': nama,
      'alamat': alamat,
      'tarif': tarif,
      'daya': daya,
      'merk_meter': merkMeter,
      'nomormeter': noMeter,
      'tahunmeter': tahunMeter,
      'fxm': faktorKaliMeter,
    };
  }
}
