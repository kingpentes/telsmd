class StandMeterModel {
  final StandData kwhMeter;
  final StandData kvarhMeter;

  StandMeterModel({
    required this.kwhMeter,
    required this.kvarhMeter,
  });

  factory StandMeterModel.fromJson(Map<String, dynamic> json) {
    return StandMeterModel(
      kwhMeter: StandData.fromJson(json['kwh_meter'] ?? {}),
      kvarhMeter: StandData.fromJson(json['kvarh_meter'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kwh_meter': kwhMeter.toJson(),
      'kvarh_meter': kvarhMeter.toJson(),
    };
  }
}

class StandData {
  final double wbp;
  final double lwbp;
  final double total;

  StandData({
    required this.wbp,
    required this.lwbp,
    required this.total,
  });

  factory StandData.fromJson(Map<String, dynamic> json) {
    return StandData(
      wbp: double.tryParse(json['wbp']?.toString() ?? '') ?? 0.0,
      lwbp: double.tryParse(json['lwbp']?.toString() ?? '') ?? 0.0,
      total: double.tryParse(json['total']?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wbp': wbp,
      'lwbp': lwbp,
      'total': total,
    };
  }
}
