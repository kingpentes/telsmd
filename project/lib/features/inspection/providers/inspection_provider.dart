import 'package:flutter/material.dart';
import '../../inspection/models/inspection_model.dart';
import '../../users/models/customer_model.dart';
import '../../kwh/models/kwh_meter_model.dart';
import '../../stanMeter/models/stan_meter_model.dart';
import '../../CT/models/ct_inspection_model.dart';
import '../../protection/models/protection_model.dart';
import '../../dokumentasi/models/documentation_model.dart';
import '../../result/models/result_model.dart';

class InspectionProvider extends ChangeNotifier {
  CustomerModel _customer = CustomerModel(
    idPel: BigInt.zero,
    unitUp: BigInt.zero,
    nama: '',
    alamat: '',
    tarif: '',
    daya: 0,
    merkMeter: '',
    noMeter: '',
    tahunMeter: 0,
    faktorKaliMeter: 0,
  );

  KwhMeterModel _kwhMeter = KwhMeterModel(
    merkMeter: '',
    typeMeter: '',
    noSeriMeter: '',
    teganganMeter: '',
    arusMeter: '',
    konstantaMeter: '',
    tahunMeter: 0,
    classMeter: '',
    kubikelMccb: '',
  );

  StanMeterModel _standMeter = StanMeterModel(
    stanKwhWbp: 0,
    stanKwhlWbp: 0,
    stanKwhTotal: 0,
    stanKvarhWbp: 0,
    stanKvarhlWbp: 0,
    stanKvarhTotal: 0,
  );

  CtInspectionModel _ctInspection = CtInspectionModel(
    ptTerpasang: '',
    ctTerpasang: '',
    ctrPrimer: 0.0,
    ctsPrimer: 0.0,
    cttPrimer: 0.0,
    ctrSekunder: 0.0,
    ctsSekunder: 0.0,
    cttSekunder: 0.0,
    ctrRatio: 0.0,
    ctsRatio: 0.0,
    cttRatio: 0.0,
    ctrError: 0.0,
    ctsError: 0.0,
    cttError: 0.0,
    ctrTegangan: 0.0,
    ctsTegangan: 0.0,
    cttTegangan: 0.0,
    cosphi: 0.0,
  );

  ProtectionModel _protection = ProtectionModel(
    kondisiProteksi: '',
    arusSettingOcr: '',
    waktuSettingOcr: '',
    thermalSettingOcr: '',
  );

  DocumentationModel _documentation = DocumentationModel(
    fotoKwh: '',
    fotoRelay: '',
    fotoKubikel: '',
    fotoHasil1: '',
    fotoHasil2: '',
    beritaAcara: '',
  );

  ResultModel _result = ResultModel(
    keterangan: '',
    kesimpulan: '',
    tindakLanjut: '',
    petugasPemeriksa: '',
  );

  CustomerModel get customer => _customer;
  KwhMeterModel get kwhMeter => _kwhMeter;
  StanMeterModel get standMeter => _standMeter;
  CtInspectionModel get ctInspection => _ctInspection;
  ProtectionModel get protection => _protection;
  DocumentationModel get documentation => _documentation;
  ResultModel get result => _result;

  InspectionModel get inspectionData => InspectionModel(
        customer: _customer,
        kwhMeter: _kwhMeter,
        standMeter: _standMeter,
        ctInspection: _ctInspection,
        protection: _protection,
        documentation: _documentation,
        result: _result,
      );

  void updateCustomer(CustomerModel data) {
    _customer = data;
    notifyListeners();
  }

  void updateKwhMeter(KwhMeterModel data) {
    _kwhMeter = data;
    notifyListeners();
  }

  void updateStandMeter(StanMeterModel data) {
    _standMeter = data;
    notifyListeners();
  }

  void updateCtInspection(CtInspectionModel data) {
    _ctInspection = data;
    notifyListeners();
  }

  void updateProtection(ProtectionModel data) {
    _protection = data;
    notifyListeners();
  }

  void updateDocumentation(DocumentationModel data) {
    _documentation = data;
    notifyListeners();
  }

  void updateResult(ResultModel data) {
    _result = data;
    notifyListeners();
  }
}
