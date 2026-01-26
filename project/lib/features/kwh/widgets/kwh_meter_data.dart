import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/kwh_meter_model.dart'; // Adjust path if necessary

class KwhMeterDataTab extends StatefulWidget {
  const KwhMeterDataTab({super.key});

  @override
  State<KwhMeterDataTab> createState() => _KwhMeterDataTabState();
}

class _KwhMeterDataTabState extends State<KwhMeterDataTab> {
  final _merkMeterController = TextEditingController();
  final _typeMeterController = TextEditingController();
  final _noSeriMeterController = TextEditingController();
  final _teganganMeterController = TextEditingController();
  final _arusMeterController = TextEditingController();
  final _konstantaMeterController = TextEditingController();
  final _tahunMeterController = TextEditingController();
  final _classMeterController = TextEditingController();
  final _kubikelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final kwhMeter = Provider.of<InspectionProvider>(context, listen: false).kwhMeter;
    _merkMeterController.text = kwhMeter.merkMeter;
    _typeMeterController.text = kwhMeter.typeMeter;
    _noSeriMeterController.text = kwhMeter.noSeriMeter;
    _teganganMeterController.text = kwhMeter.teganganMeter;
    _arusMeterController.text = kwhMeter.arusMeter;
    _konstantaMeterController.text = kwhMeter.konstantaMeter;
    _tahunMeterController.text = kwhMeter.tahunMeter == 0 ? '' : kwhMeter.tahunMeter.toString();
    _classMeterController.text = kwhMeter.classMeter;
    _kubikelController.text = kwhMeter.kubikelMccb;

    _merkMeterController.addListener(_updateProvider);
    _typeMeterController.addListener(_updateProvider);
    _noSeriMeterController.addListener(_updateProvider);
    _teganganMeterController.addListener(_updateProvider);
    _arusMeterController.addListener(_updateProvider);
    _konstantaMeterController.addListener(_updateProvider);
    _tahunMeterController.addListener(_updateProvider);
    _classMeterController.addListener(_updateProvider);
    _kubikelController.addListener(_updateProvider);
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateKwhMeter(KwhMeterModel(
      merkMeter: _merkMeterController.text,
      typeMeter: _typeMeterController.text,
      noSeriMeter: _noSeriMeterController.text,
      teganganMeter: _teganganMeterController.text,
      arusMeter: _arusMeterController.text,
      konstantaMeter: _konstantaMeterController.text,
      tahunMeter: double.tryParse(_tahunMeterController.text) ?? 0.0,
      classMeter: _classMeterController.text,
      kubikelMccb: _kubikelController.text,
    ));
  }

  @override
  void dispose() {
    _merkMeterController.dispose();
    _typeMeterController.dispose();
    _noSeriMeterController.dispose();
    _teganganMeterController.dispose();
    _arusMeterController.dispose();
    _konstantaMeterController.dispose();
    _tahunMeterController.dispose();
    _classMeterController.dispose();
    _kubikelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data KWH Meter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // field text untuk merk meter, type meter, no seri meter, tegangan meter, arus meter, konstanta meter, tahun meter, class meter, kubikel / mccb
          const SizedBox(height: 16),
          TextField(controller: _merkMeterController, decoration: const InputDecoration(labelText: 'Merk Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _typeMeterController, decoration: const InputDecoration(labelText: 'Type Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _noSeriMeterController, decoration: const InputDecoration(labelText: 'NO Seri Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _teganganMeterController, decoration: const InputDecoration(labelText: 'Tegangan Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _arusMeterController, decoration: const InputDecoration(labelText: 'Arus Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _konstantaMeterController, decoration: const InputDecoration(labelText: 'Konstanta Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _tahunMeterController, decoration: const InputDecoration(labelText: 'Tahun Meter', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _classMeterController, decoration: const InputDecoration(labelText: 'Class Meter', border: OutlineInputBorder())),
          // SizedBox(height: 16),
          // TextField(decoration: InputDecoration(labelText: 'Kubikel / MCCB', border: OutlineInputBorder())), // Not in model yet
        ],
      ),
    );
  }
}
