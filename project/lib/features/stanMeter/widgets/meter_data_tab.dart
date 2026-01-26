import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/stan_meter_model.dart'; // Adjust path if necessary

class MeterDataTab extends StatefulWidget {
  const MeterDataTab({super.key});

  @override
  State<MeterDataTab> createState() => _MeterDataTabState();
}

class _MeterDataTabState extends State<MeterDataTab> {
  // KWH
  final _kwhWbpController = TextEditingController();
  final _kwhLwbpController = TextEditingController();
  final _kwhTotalController = TextEditingController();
  
  // KVARH
  final _kvarhWbpController = TextEditingController();
  final _kvarhLwbpController = TextEditingController();
  final _kvarhTotalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final standMeter = Provider.of<InspectionProvider>(context, listen: false).standMeter;
    
    _kwhWbpController.text = standMeter.stanKwhWbp == 0 ? '' : standMeter.stanKwhWbp.toString();
    _kwhLwbpController.text = standMeter.stanKwhlWbp == 0 ? '' : standMeter.stanKwhlWbp.toString();
    _kwhTotalController.text = standMeter.stanKwhTotal == 0 ? '' : standMeter.stanKwhTotal.toString();
    
    _kvarhWbpController.text = standMeter.stanKvarhWbp == 0 ? '' : standMeter.stanKvarhWbp.toString();
    _kvarhLwbpController.text = standMeter.stanKvarhlWbp == 0 ? '' : standMeter.stanKvarhlWbp.toString();
    _kvarhTotalController.text = standMeter.stanKvarhTotal == 0 ? '' : standMeter.stanKvarhTotal.toString();

    void updateListener() => _updateProvider();

    _kwhWbpController.addListener(updateListener);
    _kwhLwbpController.addListener(updateListener);
    _kwhTotalController.addListener(updateListener);
    
    _kvarhWbpController.addListener(updateListener);
    _kvarhLwbpController.addListener(updateListener);
    _kvarhTotalController.addListener(updateListener);
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateStandMeter(StanMeterModel(
      stanKwhWbp: double.tryParse(_kwhWbpController.text) ?? 0.0,
      stanKwhlWbp: double.tryParse(_kwhLwbpController.text) ?? 0.0,
      stanKwhTotal: double.tryParse(_kwhTotalController.text) ?? 0.0,
      stanKvarhWbp: double.tryParse(_kvarhWbpController.text) ?? 0.0,
      stanKvarhlWbp: double.tryParse(_kvarhLwbpController.text) ?? 0.0,
      stanKvarhTotal: double.tryParse(_kvarhTotalController.text) ?? 0.0,
    ));
  }

  @override
  void dispose() {
    _kwhWbpController.dispose();
    _kwhLwbpController.dispose();
    _kwhTotalController.dispose();
    _kvarhWbpController.dispose();
    _kvarhLwbpController.dispose();
    _kvarhTotalController.dispose();
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
            'Data Stand Meter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('KWH Meter', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _kwhWbpController, decoration: const InputDecoration(labelText: 'WBP', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          TextField(controller: _kwhLwbpController, decoration: const InputDecoration(labelText: 'LWBP', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          TextField(controller: _kwhTotalController, decoration: const InputDecoration(labelText: 'Total', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          
          const SizedBox(height: 24),
          const Text('KVARH Meter', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(controller: _kvarhWbpController, decoration: const InputDecoration(labelText: 'WBP', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          TextField(controller: _kvarhLwbpController, decoration: const InputDecoration(labelText: 'LWBP', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          TextField(controller: _kvarhTotalController, decoration: const InputDecoration(labelText: 'Total', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
