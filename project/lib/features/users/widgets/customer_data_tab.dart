import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/services/inspection_service.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/customer_model.dart';

class CustomerDataTab extends StatefulWidget {
  const CustomerDataTab({super.key});

  @override
  State<CustomerDataTab> createState() => _CustomerDataTabState();
}

class _CustomerDataTabState extends State<CustomerDataTab> {
  final _idPelController = TextEditingController();
  final _unitUpController = TextEditingController();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _tarifController = TextEditingController();
  final _dayaController = TextEditingController();
  final _merkMeterController = TextEditingController();
  final _noMeterController = TextEditingController();
  final _tahunMeterController = TextEditingController();
  final _faktorKaliMeterController = TextEditingController();

  final _inspectionService = InspectionService();
  bool _isLoading = false;
  
  BigInt? _wilayahId;
  BigInt? _uptigaId;

  @override
  void initState() {
    super.initState();
    final customer = Provider.of<InspectionProvider>(
      context,
      listen: false,
    ).customer;
    _wilayahId = customer.wilayahId;
    _uptigaId = customer.uptigaId;
    _idPelController.text = customer.idPel == BigInt.zero
        ? ''
        : customer.idPel.toString();
    _unitUpController.text = customer.unitUp == BigInt.zero
        ? ''
        : customer.unitUp.toString();
    _namaController.text = customer.nama;
    _alamatController.text = customer.alamat;
    _tarifController.text = customer.tarif;
    _dayaController.text = customer.daya == 0 ? '' : customer.daya.toString();
    _merkMeterController.text = customer.merkMeter;
    _noMeterController.text = customer.noMeter;
    _tahunMeterController.text = customer.tahunMeter == 0
        ? ''
        : customer.tahunMeter.toString();
    _faktorKaliMeterController.text = customer.faktorKaliMeter == 0
        ? ''
        : customer.faktorKaliMeter.toString();

    // Add listeners to update provider
    _idPelController.addListener(_updateProvider);
    _unitUpController.addListener(_updateProvider);
    _namaController.addListener(_updateProvider);
    _alamatController.addListener(_updateProvider);
    _tarifController.addListener(_updateProvider);
    _dayaController.addListener(_updateProvider);
    _merkMeterController.addListener(_updateProvider);
    _noMeterController.addListener(_updateProvider);
    _tahunMeterController.addListener(_updateProvider);
    _faktorKaliMeterController.addListener(_updateProvider);
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateCustomer(
      CustomerModel(
        idPel: BigInt.tryParse(_idPelController.text) ?? BigInt.zero,
        unitUp: BigInt.tryParse(_unitUpController.text) ?? BigInt.zero,
        wilayahId: _wilayahId,
        uptigaId: _uptigaId,
        nama: _namaController.text,
        alamat: _alamatController.text,
        tarif: _tarifController.text,
        daya: double.tryParse(_dayaController.text) ?? 0.0,
        merkMeter: _merkMeterController.text,
        noMeter: _noMeterController.text,
        tahunMeter: double.tryParse(_tahunMeterController.text) ?? 0.0,
        faktorKaliMeter:
            double.tryParse(_faktorKaliMeterController.text) ?? 0.0,
      ),
    );
  }

  @override
  void dispose() {
    _idPelController.dispose();
    _unitUpController.dispose();
    _namaController.dispose();
    _alamatController.dispose();
    _tarifController.dispose();
    _dayaController.dispose();
    _merkMeterController.dispose();
    _noMeterController.dispose();
    _tahunMeterController.dispose();
    _faktorKaliMeterController.dispose();
    super.dispose();
  }

  Future<void> _searchCustomer() async {
    final id = _idPelController.text;
    if (id.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final customer = await _inspectionService.getCustomerInfoById(id);

      if (customer != null && mounted) {
        // Simpan wilayahId dan uptigaId dari hasil autofill
        _wilayahId = customer.wilayahId;
        _uptigaId = customer.uptigaId;
        
        setState(() {
          _unitUpController.text = customer.unitUp.toString();
          _namaController.text = customer.nama;
          _alamatController.text = customer.alamat;
          _tarifController.text = customer.tarif;
          _dayaController.text = customer.daya.toString();
          _merkMeterController.text = customer.merkMeter;
          _noMeterController.text = customer.noMeter;
          _tahunMeterController.text = customer.tahunMeter.toString();
          _faktorKaliMeterController.text = customer.faktorKaliMeter.toString();
        });

        _updateProvider();
        
        print('Autofill - wilayah_id: $_wilayahId, uptiga_id: $_uptigaId');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pelanggan ditemukan!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pelanggan tidak ditemukan.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Pelanggan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idPelController,
                  decoration: const InputDecoration(
                    labelText: 'ID Pelanggan',
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan ID Pelanggan',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isLoading ? null : _searchCustomer,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.search),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _unitUpController,
            decoration: const InputDecoration(
              labelText: 'Unit Up',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Pelanggan',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _alamatController,
            decoration: const InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tarifController,
            decoration: const InputDecoration(
              labelText: 'Tarif',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dayaController,
            decoration: const InputDecoration(
              labelText: 'Daya',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _merkMeterController,
            decoration: const InputDecoration(
              labelText: 'Merk Meter',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noMeterController,
            decoration: const InputDecoration(
              labelText: 'No Meter',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tahunMeterController,
            decoration: const InputDecoration(
              labelText: 'Tahun Meter',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _faktorKaliMeterController,
            decoration: const InputDecoration(
              labelText: 'Faktor Kali Meter',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
