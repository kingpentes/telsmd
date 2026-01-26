import '../../users/models/customer_model.dart';
import '../../kwh/models/kwh_meter_model.dart';
import '../../stanMeter/models/stan_meter_model.dart';
import '../../CT/models/ct_inspection_model.dart';
import '../../protection/models/protection_model.dart';
import '../../dokumentasi/models/documentation_model.dart';
import '../../result/models/result_model.dart';


class InspectionModel {
  final CustomerModel customer;
  final KwhMeterModel kwhMeter;
  final StanMeterModel standMeter;
  final CtInspectionModel ctInspection;
  final ProtectionModel protection;
  final DocumentationModel documentation;
  final ResultModel result;

  InspectionModel({
    required this.customer,
    required this.kwhMeter,
    required this.standMeter,
    required this.ctInspection,
    required this.protection,
    required this.documentation,
    required this.result,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      customer: CustomerModel.fromJson(json),
      kwhMeter: KwhMeterModel.fromJson(json),
      standMeter: StanMeterModel.fromJson(json),
      ctInspection: CtInspectionModel.fromJson(json),
      protection: ProtectionModel.fromJson(json),
      documentation: DocumentationModel.fromJson(json),
      result: ResultModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ...customer.toJson(),
      ...kwhMeter.toJson(),
      ...standMeter.toJson(),
      ...ctInspection.toJson(),
      ...protection.toJson(),
      ...documentation.toJson(),
      ...result.toJson(),
    };
  }
}
