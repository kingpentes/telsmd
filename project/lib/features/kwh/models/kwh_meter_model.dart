class KwhMeterModel {
  final String merkMeter;
  final String typeMeter;
  final String noSeriMeter;
  final String teganganMeter;
  final String arusMeter;
  final String konstantaMeter;
  final double tahunMeter;
  final String classMeter;
  final String kubikelMccb;

  KwhMeterModel({
    required this.merkMeter,
    required this.typeMeter,
    required this.noSeriMeter,
    required this.teganganMeter,
    required this.arusMeter,
    required this.konstantaMeter,
    required this.tahunMeter,
    required this.classMeter,
    required this.kubikelMccb,
  });

  factory KwhMeterModel.fromJson(Map<String, dynamic> json) {
    return KwhMeterModel(
      merkMeter: json['merk_meter'] ?? '',
      typeMeter: json['type_meter'] ?? '',
      noSeriMeter: json['no_seri_meter'] ?? '',
      teganganMeter: json['tegangan_meter'] ?? '',
      arusMeter: json['arus_meter'] ?? '',
      konstantaMeter: json['konstanta_meter'] ?? '',
      tahunMeter: json['tahun_meter'] != null ? double.tryParse(json['tahun_meter'].toString()) ?? 0.0 : 0.0,
      classMeter: json['class_meter'] ?? '',
      kubikelMccb: json['kubikel_mccb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merk_meter': merkMeter,
      'type_meter': typeMeter,
      'no_seri_meter': noSeriMeter,
      'tegangan_meter': teganganMeter,
      'arus_meter': arusMeter,
      'konstanta_meter': konstantaMeter,
      'tahun_meter': tahunMeter,
      'class_meter': classMeter,
      'kubikel_mccb': kubikelMccb,
    };
  }
}
