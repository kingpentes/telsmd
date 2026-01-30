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

  /// toJson untuk mengirim ke API 
  Future<Map<String, dynamic>> toJson({required int userId}) async {
    return {
      ...customer.toJsonForCekpot(),
      ...kwhMeter.toJson(),
      ...standMeter.toJson(),
      ...ctInspection.toJson(),
      ...protection.toJson(),
      ...await documentation.toJsonWithBase64(),
      ...result.toJson(),
      'user_id': userId,
    };
  }

  /// toJsonForDb untuk menyimpan ke SQLite lokal 
  Map<String, dynamic> toJsonForDb({required int userId}) {
    return {
      'idpel_id': customer.idPel != null ? int.tryParse(customer.idPel.toString()) : null,
      'unit_input_id': customer.unitUp != null ? int.tryParse(customer.unitUp.toString()) : null,
      'wilayah_id': customer.wilayahId != null ? int.tryParse(customer.wilayahId.toString()) : null,
      'uptiga_id': customer.uptigaId != null ? int.tryParse(customer.uptigaId.toString()) : null,
      'nama': customer.nama,
      'alamat': customer.alamat,
      'tarif': customer.tarif,
      'daya': customer.daya,
      'merk_meter': customer.merkMeter,
      'nomormeter': customer.noMeter,
      'type_meter': customer.tahunMeter.toString(),
      'fxm': customer.faktorKaliMeter,
      'ct': customer.ct,
      ...kwhMeter.toJson(),
      ...standMeter.toJson(),
      ...ctInspection.toJson(),
      ...protection.toJson(),
      ...documentation.toJson(),
      ...result.toJson(),
      'user_id': userId,
    };
  }

  /// toJsonForMultipart untuk mengirim ke API
  Future<Map<String, dynamic>> toJsonForMultipart({required int userId}) async {
    return {
      ...customer.toJsonForCekpot(),
      ...kwhMeter.toJson(),
      ...standMeter.toJson(),
      ...ctInspection.toJson(),
      ...protection.toJson(),
      ...result.toJson(),
      'user_id': userId,
    };
  }
}
