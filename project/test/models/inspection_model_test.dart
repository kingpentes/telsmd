import 'package:flutter_test/flutter_test.dart';
import '../../lib/features/inspection/models/inspection_model.dart';
import '../../lib/features/users/models/customer_model.dart';
import '../../lib/features/kwh/models/kwh_meter_model.dart';
import '../../lib/features/stanMeter/models/stand_meter_model.dart';
import '../../lib/features/CT/models/ct_inspection_model.dart';
import '../../lib/features/maintenance/models/protection_model.dart';
import '../../lib/features/dokumentasi/models/documentation_model.dart';
import '../../lib/features/hasil/models/result_model.dart';

void main() {
  test('InspectionModel serialization test', () {
    final json = {
      'customer': {
        'id_pel': '12345',
        'unit_up': 'UNIT01',
        'nama': 'John Doe',
        'alamat': 'Jalan Raya No 1',
        'tarif': 'R1',
        'daya': 1300,
        'merk_meter': 'Merk A',
        'no_meter': 'M123',
        'tahun_meter': '2020',
        'faktor_kali_meter': 1.0,
      },
      'kwh_meter': {
        'merk_meter': 'Merk A',
        'type_meter': 'Type 1',
        'no_seri_meter': 'S123',
        'tegangan_meter': '220V',
        'arus_meter': '5A',
        'konstanta_meter': 1000.0,
        'tahun_meter': '2020',
        'class_meter': 'Class 1',
        'kubikel_mccb': 'MCCB 1',
      },
      'stand_meter': {
        'kwh_meter': {'wbp': 100.0, 'lwbp': 200.0, 'total': 300.0},
        'kvarh_meter': {'wbp': 10.0, 'lwbp': 20.0, 'total': 30.0},
      },
      'ct_inspection': {
        'pt_terpasang': 'PT1',
        'ct_terpasang': 'CT1',
        'arus_ct_primer': {'r': 1.0, 's': 1.0, 't': 1.0},
        'arus_ct_sekunder': {'r': 0.1, 's': 0.1, 't': 0.1},
        'ratio_ct': {'r': 10.0, 's': 10.0, 't': 10.0},
        'error_ct': {'r': 0.1, 's': 0.1, 't': 0.1},
        'tegangan': {'r': 220.0, 's': 220.0, 't': 220.0},
        'cosphi': 0.9,
      },
      'protection': {
        'kondisi_proteksi': 'Good',
        'arus_setting_ocr': 10.0,
        'waktu_setting_ocr': 0.5,
        'thermal_setting_ocr': 5.0,
      },
      'documentation': {
        'foto_kwh': 'path/to/kwh.jpg',
        'foto_relay': 'path/to/relay.jpg',
        'foto_kubikel': 'path/to/kubikel.jpg',
        'foto_hasil_1': 'path/to/hasil1.jpg',
        'foto_hasil_2': 'path/to/hasil2.jpg',
        'berita_acara': 'path/to/ba.pdf',
      },
      'result': {
        'keterangan': 'OK',
        'kesimpulan': 'Normal',
        'tindak_lanjut': 'None',
        'petugas_pemeriksa': 'Officer A',
      }
    };

    final model = InspectionModel.fromJson(json);

    expect(model.customer.nama, 'John Doe');
    expect(model.kwhMeter.teganganMeter, '220V');
    expect(model.standMeter.kwhMeter.total, 300.0);
    expect(model.ctInspection.cosphi, 0.9);
    expect(model.protection.kondisiProteksi, 'Good');

    final jsonOutput = model.toJson();
    expect(jsonOutput['customer']['nama'], 'John Doe');
  });
}
