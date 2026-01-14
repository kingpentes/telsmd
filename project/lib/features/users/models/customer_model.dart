class CustomerModel {
  final String idPel;
  final String unitUp;
  final String nama;
  final String alamat;
  final String tarif;
  final int daya;
  final String merkMeter;
  final String noMeter;
  final String tahunMeter;
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
      idPel: json['id_pel'] ?? '',
      unitUp: json['unit_up'] ?? '',
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      tarif: json['tarif'] ?? '',
      daya: json['daya'] is int ? json['daya'] : int.tryParse(json['daya'].toString()) ?? 0,
      merkMeter: json['merk_meter'] ?? '',
      noMeter: json['no_meter'] ?? '',
      tahunMeter: json['tahun_meter'] ?? '',
      faktorKaliMeter: json['faktor_kali_meter'] is double 
          ? json['faktor_kali_meter'] 
          : double.tryParse(json['faktor_kali_meter'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pel': idPel,
      'unit_up': unitUp,
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
