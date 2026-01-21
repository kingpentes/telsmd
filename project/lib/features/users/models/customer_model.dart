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
      idPel: json['id_pel'] != null ? BigInt.tryParse(json['id_pel'].toString()) ?? BigInt.zero : BigInt.zero,
      unitUp: json['unit_up'] != null ? BigInt.tryParse(json['unit_up'].toString()) ?? BigInt.zero : BigInt.zero,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      tarif: json['tarif'] ?? '',
      daya: json['daya'] != null ? double.tryParse(json['daya'].toString()) ?? 0.0 : 0.0,
      merkMeter: json['merk_meter'] ?? '',
      noMeter: json['no_meter'] ?? '',
      tahunMeter: json['tahun_meter'] != null ? double.tryParse(json['tahun_meter'].toString()) ?? 0.0 : 0.0,
      faktorKaliMeter: json['faktor_kali_meter'] != null 
          ? double.tryParse(json['faktor_kali_meter'].toString()) ?? 0.0 
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pel': idPel.toString(),
      'unit_up': unitUp.toString(),
      'nama': nama,
      'alamat': alamat,
      'tarif': tarif,
      'daya': daya,
      'merk_meter': merkMeter,
      'no_meter': noMeter,
      'tahun_meter': tahunMeter,
      'faktor_kali_meter': faktorKaliMeter,
    };
  }
}
