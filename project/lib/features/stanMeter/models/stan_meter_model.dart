class StanMeterModel {
  final double stanKwhWbp;
  final double stanKwhlWbp;
  final double stanKwhTotal;
  final double stanKvarhWbp;
  final double stanKvarhlWbp;
  final double stanKvarhTotal;

  StanMeterModel({
    required this.stanKwhWbp,
    required this.stanKwhlWbp,
    required this.stanKwhTotal,
    required this.stanKvarhWbp,
    required this.stanKvarhlWbp,
    required this.stanKvarhTotal,
  });

  factory StanMeterModel.fromJson(Map<String, dynamic> json) {
    return StanMeterModel(
      stanKwhWbp: double.tryParse(json['kwhwbp']?.toString() ?? '') ?? 0,
      stanKwhlWbp: double.tryParse(json['kwhlwbp']?.toString() ?? '') ?? 0,
      stanKwhTotal: double.tryParse(json['kwhtotal']?.toString() ?? '') ?? 0,
      stanKvarhWbp: double.tryParse(json['kvarhwbp']?.toString() ?? '') ?? 0,
      stanKvarhlWbp: double.tryParse(json['kvarhlwbp']?.toString() ?? '') ?? 0,
      stanKvarhTotal: double.tryParse(json['kvarhtotal']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kwhwbp': stanKwhWbp,
      'kwhlwbp': stanKwhlWbp,
      'kwhtotal': stanKwhTotal,
      'kvarhwbp': stanKvarhWbp,
      'kvarhlwbp': stanKvarhlWbp,
      'kvarhtotal': stanKvarhTotal,
    };
  }
}
