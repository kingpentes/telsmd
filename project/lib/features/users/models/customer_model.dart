class CustomerModel {
  final BigInt? idPel;
  final BigInt? unitUp;
  final BigInt? wilayahId;  
  final BigInt? uptigaId;   
  final String nama;
  final String alamat;
  final String tarif;
  final double daya;
  final String merkMeter;
  final String noMeter;
  final double tahunMeter;
  final double faktorKaliMeter;
  final String mccb;
  final String ct;
  final String koordinat;
  final BigInt? contactperson;

  CustomerModel({
    this.idPel,
    this.unitUp,
    this.wilayahId,
    this.uptigaId,
    required this.nama,
    required this.alamat,
    required this.tarif,
    required this.daya,
    required this.merkMeter,
    required this.noMeter,
    required this.tahunMeter,
    required this.faktorKaliMeter,
    this.mccb = '',
    this.ct = '',
    this.koordinat = '',
    this.contactperson,
  });


  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    final idPelValue = json['idpel'] ?? json['idpel_id'];
    final unitUpValue = json['unitup'] ?? json['unit_input_id'];
    
    return CustomerModel(
      idPel: idPelValue != null
          ? BigInt.tryParse(idPelValue.toString()) ?? BigInt.zero
          : BigInt.zero,
      unitUp: unitUpValue != null
          ? BigInt.tryParse(unitUpValue.toString()) ?? BigInt.zero
          : BigInt.zero,
      wilayahId: json['wilayah_id'] != null 
          ? BigInt.tryParse(json['wilayah_id'].toString()) 
          : null,
      uptigaId: json['uptiga_id'] != null 
          ? BigInt.tryParse(json['uptiga_id'].toString()) 
          : null,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      tarif: json['tarif'] ?? '',
      daya: json['daya'] != null
          ? double.tryParse(json['daya'].toString()) ?? 0.0
          : 0.0,
      merkMeter: json['merk_meter'] ?? '',
      noMeter: json['no_meter'] ?? json['nomormeter'] ?? '',
      tahunMeter: json['type_meter'] != null
          ? double.tryParse(json['type_meter'].toString()) ?? 0.0
          : 0.0,
      faktorKaliMeter: json['faktor_kali'] != null
          ? double.tryParse(json['faktor_kali'].toString()) ?? 0.0
          : (json['fxm'] != null 
              ? double.tryParse(json['fxm'].toString()) ?? 0.0 
              : 0.0),
      mccb: json['mccb'] ?? '',
      ct: json['ct'] ?? '',
      koordinat: json['koordinat'] ?? '',
      contactperson: json['no_telepon_pic'] != null
          ? BigInt.tryParse(json['no_telepon_pic'].toString()) ?? BigInt.zero
          : BigInt.zero,
    );
  }

  /// toJson untuk mengirim ke API cekpot (menggunakan format cek_potensials)
  Map<String, dynamic> toJsonForCekpot() {
    return {
      'idpel': idPel.toString(),
      'unitup': unitUp.toString(),
      'wilayah_id': wilayahId?.toString(),
      'uptiga_id': uptigaId?.toString(),
      'nama': nama,
      'alamat': alamat,
      'tarif': tarif,
      'daya': daya,
      'merk_meter': merkMeter,
      'nomormeter': noMeter,
      'type_meter': tahunMeter,
      'fxm': faktorKaliMeter,
      'mccb': mccb,
      'ct': ct,
      'koordinat': koordinat,
      'no_telepon_pic': contactperson.toString(),
    };
  }

  /// toJson untuk format dilplgbesars (CustomerScreen)
  Map<String, dynamic> toJson() {
    return {
      'idpel': idPel.toString(),
      'unitup': unitUp.toString(),
      'nama': nama,
      'alamat': alamat,
      'tarif': tarif,
      'daya': daya,
      'merk_meter': merkMeter,
      'no_meter': noMeter,
      'type_meter': tahunMeter,
      'faktor_kali': faktorKaliMeter,
      'mccb': mccb,
      'ct': ct,
      'koordinat': koordinat,
      'no_telepon_pic': contactperson.toString(),
    };
  }
}
