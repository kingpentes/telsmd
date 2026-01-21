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
      stanKwhWbp: double.tryParse(json['stan_kwh_wbp']?.toString() ?? '') ?? 0,
      stanKwhlWbp: double.tryParse(json['stan_kwh_lwbp']?.toString() ?? '') ?? 0,
      stanKwhTotal: double.tryParse(json['stan_kwh_total']?.toString() ?? '') ?? 0,
      stanKvarhWbp: double.tryParse(json['stan_kvarh_wbp']?.toString() ?? '') ?? 0,
      stanKvarhlWbp: double.tryParse(json['stan_kvarh_lwbp']?.toString() ?? '') ?? 0,
      stanKvarhTotal: double.tryParse(json['stan_kvarh_total']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stan_kwh_wbp': stanKwhWbp,
      'stan_kwh_lwbp': stanKwhlWbp,
      'stan_kwh_total': stanKwhTotal,
      'stan_kvarh_wbp': stanKvarhWbp,
      'stan_kvarh_lwbp': stanKvarhlWbp,
      'stan_kvarh_total': stanKvarhTotal,
    };
  }
}
