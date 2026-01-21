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
      noSeriMeter: json['nomormeter'] ?? '',
      teganganMeter: json['teganganmeter'] ?? '',
      arusMeter: json['arusmeter'] ?? '',
      konstantaMeter: json['konsmeter'] ?? '',
      tahunMeter: json['tahunmeter'] != null ? double.tryParse(json['tahunmeter'].toString()) ?? 0.0 : 0.0,
      classMeter: json['classmeter'] ?? '',
      kubikelMccb: json['pemb_arus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merk_meter': merkMeter,
      'type_meter': typeMeter,
      'nomormeter': noSeriMeter,
      'teganganmeter': teganganMeter,
      'arusmeter': arusMeter,
      'konsmeter': konstantaMeter,
      'tahunmeter': tahunMeter,
      'classmeter': classMeter,
      'pemb_arus': kubikelMccb,
    };
  }
}
