class CtInspectionModel {
  final String ptTerpasang;
  final String ctTerpasang;
  final double ctrPrimer;
  final double ctsPrimer;
  final double cttPrimer;
  final double ctrSekunder;
  final double ctsSekunder;
  final double cttSekunder;
  final double ctrRatio;
  final double ctsRatio;
  final double cttRatio;
  final double ctrError;
  final double ctsError;
  final double cttError;
  final double ctrTegangan;
  final double ctsTegangan;
  final double cttTegangan;
  final double cosphi;

  CtInspectionModel({
    required this.ptTerpasang,
    required this.ctTerpasang,
    required this.ctrPrimer,
    required this.ctsPrimer,
    required this.cttPrimer,
    required this.ctrSekunder,
    required this.ctsSekunder,
    required this.cttSekunder,
    required this.ctrRatio,
    required this.ctsRatio,
    required this.cttRatio,
    required this.ctrError,
    required this.ctsError,
    required this.cttError,
    required this.ctrTegangan,
    required this.ctsTegangan,
    required this.cttTegangan,
    required this.cosphi,
  });

  factory CtInspectionModel.fromJson(Map<String, dynamic> json) {
    return CtInspectionModel(
      ptTerpasang: json['pt'] ?? '',
      ctTerpasang: json['ct'] ?? '',
      ctrPrimer: double.tryParse(json['ctr']?.toString() ?? '') ?? 0.0,
      ctsPrimer: double.tryParse(json['cts']?.toString() ?? '') ?? 0.0,
      cttPrimer: double.tryParse(json['ctt']?.toString() ?? '') ?? 0.0,
      ctrSekunder: double.tryParse(json['ctsr']?.toString() ?? '') ?? 0.0,
      ctsSekunder: double.tryParse(json['ctss']?.toString() ?? '') ?? 0.0,
      cttSekunder: double.tryParse(json['ctst']?.toString() ?? '') ?? 0.0,
      ctrRatio: double.tryParse(json['ctr_ratio']?.toString() ?? '') ?? 0.0,
      ctsRatio: double.tryParse(json['cts_ratio']?.toString() ?? '') ?? 0.0,
      cttRatio: double.tryParse(json['ctt_ratio']?.toString() ?? '') ?? 0.0,
      ctrError: double.tryParse(json['ectr']?.toString() ?? '') ?? 0.0,
      ctsError: double.tryParse(json['ects']?.toString() ?? '') ?? 0.0,
      cttError: double.tryParse(json['ectt']?.toString() ?? '') ?? 0.0,
      ctrTegangan: double.tryParse(json['vr']?.toString() ?? '') ?? 0.0,
      ctsTegangan: double.tryParse(json['vs']?.toString() ?? '') ?? 0.0,
      cttTegangan: double.tryParse(json['vt']?.toString() ?? '') ?? 0.0,
      cosphi: double.tryParse(json['cosphi']?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pt': ptTerpasang,
      'ct': ctTerpasang,
      'ctr': ctrPrimer,
      'cts': ctsPrimer,
      'ctt': cttPrimer,
      'ctsr': ctrSekunder,
      'ctss': ctsSekunder,
      'ctst': cttSekunder,
      'ctr_ratio': ctrRatio,
      'cts_ratio': ctsRatio,
      'ctt_ratio': cttRatio,
      'ectr': ctrError,
      'ects': ctsError,
      'ectt': cttError,
      'vr': ctrTegangan,
      'vs': ctsTegangan,
      'vt': cttTegangan,
      'cosphi': cosphi,
    };
  }
}

