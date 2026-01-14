class CtInspectionModel {
  final String ptTerpasang;
  final String ctTerpasang;
  final PhaseData arusCtPrimer;
  final PhaseData arusCtSekunder;
  final PhaseData ratioCt;
  final PhaseData errorCt;
  final PhaseData tegangan;
  final double cosphi;

  CtInspectionModel({
    required this.ptTerpasang,
    required this.ctTerpasang,
    required this.arusCtPrimer,
    required this.arusCtSekunder,
    required this.ratioCt,
    required this.errorCt,
    required this.tegangan,
    required this.cosphi,
  });

  factory CtInspectionModel.fromJson(Map<String, dynamic> json) {
    return CtInspectionModel(
      ptTerpasang: json['pt_terpasang'] ?? '',
      ctTerpasang: json['ct_terpasang'] ?? '',
      arusCtPrimer: PhaseData.fromJson(json['arus_ct_primer'] ?? {}),
      arusCtSekunder: PhaseData.fromJson(json['arus_ct_sekunder'] ?? {}),
      ratioCt: PhaseData.fromJson(json['ratio_ct'] ?? {}),
      errorCt: PhaseData.fromJson(json['error_ct'] ?? {}),
      tegangan: PhaseData.fromJson(json['tegangan'] ?? {}),
      cosphi: double.tryParse(json['cosphi']?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pt_terpasang': ptTerpasang,
      'ct_terpasang': ctTerpasang,
      'arus_ct_primer': arusCtPrimer.toJson(),
      'arus_ct_sekunder': arusCtSekunder.toJson(),
      'ratio_ct': ratioCt.toJson(),
      'error_ct': errorCt.toJson(),
      'tegangan': tegangan.toJson(),
      'cosphi': cosphi,
    };
  }
}

class PhaseData {
  final double r;
  final double s;
  final double t;

  PhaseData({
    required this.r,
    required this.s,
    required this.t,
  });

  factory PhaseData.fromJson(Map<String, dynamic> json) {
    return PhaseData(
      r: double.tryParse(json['r']?.toString() ?? '') ?? 0.0,
      s: double.tryParse(json['s']?.toString() ?? '') ?? 0.0,
      t: double.tryParse(json['t']?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'r': r,
      's': s,
      't': t,
    };
  }
}
