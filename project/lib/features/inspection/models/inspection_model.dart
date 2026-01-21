import '../../users/models/customer_model.dart';
import '../../kwh/models/kwh_meter_model.dart';
import '../../stanMeter/models/stand_meter_model.dart';
import '../../CT/models/ct_inspection_model.dart';
import '../../maintenance/models/protection_model.dart';
import '../../dokumentasi/models/documentation_model.dart';
import '../../hasil/models/result_model.dart';


class InspectionModel {
  final CustomerModel customer;
  final KwhMeterModel kwhMeter;
  final StandMeterModel standMeter;
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
      customer: CustomerModel.fromJson(json['customer'] ?? {}),
      kwhMeter: KwhMeterModel.fromJson(json['kwh_meter'] ?? {}),
      standMeter: StandMeterModel.fromJson(json['stand_meter'] ?? {}),
      ctInspection: CtInspectionModel.fromJson(json['ct_inspection'] ?? {}),
      protection: ProtectionModel.fromJson(json['protection'] ?? {}),
      documentation: DocumentationModel.fromJson(json['documentation'] ?? {}),
      result: ResultModel.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer.toJson(),
      'kwh_meter': kwhMeter.toJson(),
      'stand_meter': standMeter.toJson(),
      'ct_inspection': ctInspection.toJson(),
      'protection': protection.toJson(),
      'documentation': documentation.toJson(),
      'result': result.toJson(),
    };
  }
}
