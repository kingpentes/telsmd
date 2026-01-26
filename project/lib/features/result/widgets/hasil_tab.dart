import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../../inspection/services/inspection_service.dart';
import '../models/result_model.dart';

class ResultTab extends StatefulWidget {
  const ResultTab({super.key});

  @override
  State<ResultTab> createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  String? _selectedKeterangan;
  final _kesimpulanController = TextEditingController();
  final _tindakLanjutController = TextEditingController();
  final _petugasPemeriksaController = TextEditingController();

  final List<String> _keteranganOptions = ['Normal', 'Anomali'];

  @override
  void initState() {
    super.initState();
    final result = Provider.of<InspectionProvider>(context, listen: false).result;
    
    if (_keteranganOptions.contains(result.keterangan)) {
      _selectedKeterangan = result.keterangan;
    }

    _kesimpulanController.text = result.kesimpulan;
    _tindakLanjutController.text = result.tindakLanjut;
    _petugasPemeriksaController.text = result.petugasPemeriksa;

    void updateListener() {
      _updateProvider();
    }

    _kesimpulanController.addListener(updateListener);
    _tindakLanjutController.addListener(updateListener);
    _petugasPemeriksaController.addListener(updateListener);
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateResult(ResultModel(
      keterangan: _selectedKeterangan ?? '',
      kesimpulan: _kesimpulanController.text,
      tindakLanjut: _tindakLanjutController.text,
      petugasPemeriksa: _petugasPemeriksaController.text,
    ));
  }

  @override
  void dispose() {
    _kesimpulanController.dispose();
    _tindakLanjutController.dispose();
    _petugasPemeriksaController.dispose();
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
            'Hasil Akhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // field text untuk keterangan, kesimpulan, tindak lanjut, petugas pemeriksa
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Keterangan', border: OutlineInputBorder()),
            value: _selectedKeterangan,
            items: _keteranganOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedKeterangan = newValue;
              });
              _updateProvider();
            },
          ),
          const SizedBox(height: 16),
          TextField(controller: _kesimpulanController, decoration: const InputDecoration(labelText: 'Kesimpulan', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _tindakLanjutController, decoration: const InputDecoration(labelText: 'Tindak Lanjut', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _petugasPemeriksaController, decoration: const InputDecoration(labelText: 'Petugas Pemeriksa', border: OutlineInputBorder())),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menyimpan Data Pemeriksaan...')),
                );
                
                // Get real data from provider
                final inspectionData = Provider.of<InspectionProvider>(context, listen: false).inspectionData;
                final service = InspectionService();
                
                final success = await service.submitInspection(inspectionData);
                
                if (context.mounted) {
                  if (success) {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil disimpan (dikirim atau backlog)')),
                    );
                  } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal menyimpan data')),
                    );
                  }
                }
              },
              child: const Text('Simpan Pemeriksaan', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}


