import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/protection_model.dart';

class MaintenanceTab extends StatefulWidget {
  const MaintenanceTab({super.key});

  @override
  State<MaintenanceTab> createState() => _MaintenanceTabState();
}

class _MaintenanceTabState extends State<MaintenanceTab> {
  String? _selectedKondisi;
  final _arusSettingOcrController = TextEditingController();
  final _waktuSettingOcrController = TextEditingController();
  final _thermalSettingOcrController = TextEditingController();

  final List<String> _kondisiOption = ['Operasi', 'Tidak Operasi'];

  @override
  void initState() {
    super.initState();
    final protection = Provider.of<InspectionProvider>(context, listen: false).protection;
    
    // Set initial value for Dropdown, ensure it's in the list or null
    if (_kondisiOption.contains(protection.kondisiProteksi)) {
      _selectedKondisi = protection.kondisiProteksi;
    } else if (protection.kondisiProteksi.isNotEmpty) {
       // If saved value is not in option (e.g. from text input before), maybe add it or ignore?
       // ideally we stick to options. For now default to null if invalid.
    }

    _arusSettingOcrController.text = protection.arusSettingOcr;
    _waktuSettingOcrController.text = protection.waktuSettingOcr;
    _thermalSettingOcrController.text = protection.thermalSettingOcr;

    void updateListener() {
      _updateProvider();
    }

    // Dropdown doesn't use listener, it updates on change
    _arusSettingOcrController.addListener(updateListener);
    _waktuSettingOcrController.addListener(updateListener);
    _thermalSettingOcrController.addListener(updateListener);
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateProtection(ProtectionModel(
      kondisiProteksi: _selectedKondisi ?? '',
      arusSettingOcr: _arusSettingOcrController.text,
      waktuSettingOcr: _waktuSettingOcrController.text,
      thermalSettingOcr: _thermalSettingOcrController.text,
    ));
  }

  @override
  void dispose() {
    _arusSettingOcrController.dispose();
    _waktuSettingOcrController.dispose();
    _thermalSettingOcrController.dispose();
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
            'Pemeliharaan Proteksi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Kondisi Proteksi', border: OutlineInputBorder()),
            value: _selectedKondisi,
            items: _kondisiOption.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedKondisi = newValue;
              });
              _updateProvider();
            },
          ),
          const SizedBox(height: 16),
          TextField(controller: _arusSettingOcrController, decoration: const InputDecoration(labelText: 'Arus Setting OCR', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _waktuSettingOcrController, decoration: const InputDecoration(labelText: 'Waktu Setting OCR', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _thermalSettingOcrController, decoration: const InputDecoration(labelText: 'Thermal Setting OCR', border: OutlineInputBorder())),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
