import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/ct_inspection_model.dart';

class CtDataTab extends StatefulWidget {
  const CtDataTab({super.key});

  @override
  State<CtDataTab> createState() => _CtDataTabState();
}

class _CtDataTabState extends State<CtDataTab> {
  final _ptTerpasangController = TextEditingController();
  final _ctTerpasangController = TextEditingController();
  final _nameplatePrimerController = TextEditingController();
  final _nameplateSekunderController = TextEditingController();
  
  // CT Primer
  final _ctrPrimerController = TextEditingController();
  final _ctsPrimerController = TextEditingController();
  final _cttPrimerController = TextEditingController();
  
  // CT Sekunder
  final _ctrSekunderController = TextEditingController();
  final _ctsSekunderController = TextEditingController();
  final _cttSekunderController = TextEditingController();
  
  // Ratio
  final _ctrRatioController = TextEditingController();
  final _ctsRatioController = TextEditingController();
  final _cttRatioController = TextEditingController();
  
  // Error
  final _ctrErrorController = TextEditingController();
  final _ctsErrorController = TextEditingController();
  final _cttErrorController = TextEditingController();
  
  // Tegangan
  final _ctrTeganganController = TextEditingController();
  final _ctsTeganganController = TextEditingController();
  final _cttTeganganController = TextEditingController();
  
  final _cosphiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final ct = Provider.of<InspectionProvider>(context, listen: false).ctInspection;
    
    _ptTerpasangController.text = ct.ptTerpasang;
    _ctTerpasangController.text = ct.ctTerpasang;

    if (ct.ctTerpasang.contains('/')) {
      final parts = ct.ctTerpasang.split('/');
      if (parts.length == 2) {
        _nameplatePrimerController.text = parts[0];
        _nameplateSekunderController.text = parts[1];
      }
    }
    
    _ctrPrimerController.text = ct.ctrPrimer == 0 ? '' : ct.ctrPrimer.toString();
    _ctsPrimerController.text = ct.ctsPrimer == 0 ? '' : ct.ctsPrimer.toString();
    _cttPrimerController.text = ct.cttPrimer == 0 ? '' : ct.cttPrimer.toString();
    
    _ctrSekunderController.text = ct.ctrSekunder == 0 ? '' : ct.ctrSekunder.toString();
    _ctsSekunderController.text = ct.ctsSekunder == 0 ? '' : ct.ctsSekunder.toString();
    _cttSekunderController.text = ct.cttSekunder == 0 ? '' : ct.cttSekunder.toString();
    
    _ctrRatioController.text = ct.ctrRatio == 0 ? '' : ct.ctrRatio.toString();
    _ctsRatioController.text = ct.ctsRatio == 0 ? '' : ct.ctsRatio.toString();
    _cttRatioController.text = ct.cttRatio == 0 ? '' : ct.cttRatio.toString();
    
    _ctrErrorController.text = ct.ctrError == 0 ? '' : ct.ctrError.toString();
    _ctsErrorController.text = ct.ctsError == 0 ? '' : ct.ctsError.toString();
    _cttErrorController.text = ct.cttError == 0 ? '' : ct.cttError.toString();
    
    _ctrTeganganController.text = ct.ctrTegangan == 0 ? '' : ct.ctrTegangan.toString();
    _ctsTeganganController.text = ct.ctsTegangan == 0 ? '' : ct.ctsTegangan.toString();
    _cttTeganganController.text = ct.cttTegangan == 0 ? '' : ct.cttTegangan.toString();
    
    _cosphiController.text = ct.cosphi == 0 ? '' : ct.cosphi.toString();

    void updateListener() => _updateProvider();
    
    _ptTerpasangController.addListener(updateListener);
    _ctTerpasangController.addListener(updateListener);
    
    // Calculation Listeners
    _nameplatePrimerController.addListener(_calculateValues);
    _nameplateSekunderController.addListener(_calculateValues);
    
    _ctrPrimerController.addListener(_calculateValues);
    _ctsPrimerController.addListener(_calculateValues);
    _cttPrimerController.addListener(_calculateValues);
    
    _ctrSekunderController.addListener(_calculateValues);
    _ctsSekunderController.addListener(_calculateValues);
    _cttSekunderController.addListener(_calculateValues);
    
    _nameplatePrimerController.addListener(updateListener);
    _nameplateSekunderController.addListener(updateListener);
    _ctrPrimerController.addListener(updateListener);
    _ctsPrimerController.addListener(updateListener);
    _cttPrimerController.addListener(updateListener);
    _ctrSekunderController.addListener(updateListener);
    _ctsSekunderController.addListener(updateListener);
    _cttSekunderController.addListener(updateListener);
    _ctrRatioController.addListener(updateListener);
    _ctsRatioController.addListener(updateListener);
    _cttRatioController.addListener(updateListener);
    _ctrErrorController.addListener(updateListener);
    _ctsErrorController.addListener(updateListener);
    _cttErrorController.addListener(updateListener);
    _ctrTeganganController.addListener(updateListener);
    _ctsTeganganController.addListener(updateListener);
    _cttTeganganController.addListener(updateListener);
    _cosphiController.addListener(updateListener);
  }

  void _calculateValues() {
    // 1. Update CT Terpasang
    final npPrimer = _nameplatePrimerController.text;
    final npSekunder = _nameplateSekunderController.text;
    if (npPrimer.isNotEmpty && npSekunder.isNotEmpty) {
      final newVal = '$npPrimer/$npSekunder';
      if (_ctTerpasangController.text != newVal) {
        _ctTerpasangController.text = newVal;
      }
    }

    // Helpers
    double parse(String text) => double.tryParse(text) ?? 0.0;
    String format(double val) => val.toStringAsFixed(2);

    final p_r = parse(_ctrPrimerController.text);
    final p_s = parse(_ctsPrimerController.text);
    final p_t = parse(_cttPrimerController.text);

    final s_r = parse(_ctrSekunderController.text);
    final s_s = parse(_ctsSekunderController.text);
    final s_t = parse(_cttSekunderController.text);

    // 2. Calculate Ratio: Measured Primer / Measured Sekunder
    if (s_r != 0) _ctrRatioController.text = format(p_r / s_r);
    if (s_s != 0) _ctsRatioController.text = format(p_s / s_s);
    if (s_t != 0) _cttRatioController.text = format(p_t / s_t);

    // 3. Calculate Error
    // Nameplate Ratio
    final double? np_p = double.tryParse(npPrimer);
    final double? np_s = double.tryParse(npSekunder);
    
    if (np_p != null && np_s != null && np_s != 0) {
      double nameplateRatio = np_p / np_s;

      if (s_r != 0) {
        double measuredRatioR = p_r / s_r;
        double errorR = ((nameplateRatio - measuredRatioR) / nameplateRatio) * 100;
        _ctrErrorController.text = format(errorR);
      }
      
      if (s_s != 0) {
        double measuredRatioS = p_s / s_s;
        double errorS = ((nameplateRatio - measuredRatioS) / nameplateRatio) * 100;
        _ctsErrorController.text = format(errorS);
      }

      if (s_t != 0) {
        double measuredRatioT = p_t / s_t;
        double errorT = ((nameplateRatio - measuredRatioT) / nameplateRatio) * 100;
        _cttErrorController.text = format(errorT);
      }
    }
  }

  void _updateProvider() {
    final provider = Provider.of<InspectionProvider>(context, listen: false);
    provider.updateCtInspection(CtInspectionModel(
      ptTerpasang: _ptTerpasangController.text,
      ctTerpasang: _ctTerpasangController.text,
      ctrPrimer: double.tryParse(_ctrPrimerController.text) ?? 0.0,
      ctsPrimer: double.tryParse(_ctsPrimerController.text) ?? 0.0,
      cttPrimer: double.tryParse(_cttPrimerController.text) ?? 0.0,
      ctrSekunder: double.tryParse(_ctrSekunderController.text) ?? 0.0,
      ctsSekunder: double.tryParse(_ctsSekunderController.text) ?? 0.0,
      cttSekunder: double.tryParse(_cttSekunderController.text) ?? 0.0,
      ctrRatio: double.tryParse(_ctrRatioController.text) ?? 0.0,
      ctsRatio: double.tryParse(_ctsRatioController.text) ?? 0.0,
      cttRatio: double.tryParse(_cttRatioController.text) ?? 0.0,
      ctrError: double.tryParse(_ctrErrorController.text) ?? 0.0,
      ctsError: double.tryParse(_ctsErrorController.text) ?? 0.0,
      cttError: double.tryParse(_cttErrorController.text) ?? 0.0,
      ctrTegangan: double.tryParse(_ctrTeganganController.text) ?? 0.0,
      ctsTegangan: double.tryParse(_ctsTeganganController.text) ?? 0.0,
      cttTegangan: double.tryParse(_cttTeganganController.text) ?? 0.0,
      cosphi: double.tryParse(_cosphiController.text) ?? 0.0,
    ));
  }

  @override
  void dispose() {
    _ptTerpasangController.dispose();
    _ctTerpasangController.dispose();
    _nameplatePrimerController.dispose();
    _nameplateSekunderController.dispose();
    _ctrPrimerController.dispose();
    _ctsPrimerController.dispose();
    _cttPrimerController.dispose();
    _ctrSekunderController.dispose();
    _ctsSekunderController.dispose();
    _cttSekunderController.dispose();
    _ctrRatioController.dispose();
    _ctsRatioController.dispose();
    _cttRatioController.dispose();
    _ctrErrorController.dispose();
    _ctsErrorController.dispose();
    _cttErrorController.dispose();
    _ctrTeganganController.dispose();
    _ctsTeganganController.dispose();
    _cttTeganganController.dispose();
    _cosphiController.dispose();
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
            'Data Pengukuran CT',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(controller: _ptTerpasangController, decoration: const InputDecoration(labelText: 'PT Terpasang', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _ptTerpasangController, decoration: const InputDecoration(labelText: 'PT Terpasang', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          // TextField(controller: _ctTerpasangController, decoration: const InputDecoration(labelText: 'CT Terpasang', border: OutlineInputBorder())),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameplatePrimerController,
                  decoration: const InputDecoration(labelText: 'Primer (Nameplate)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              const Text('/', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _nameplateSekunderController,
                  decoration: const InputDecoration(labelText: 'Sekunder (Nameplate)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Arus CT Primer (Ampere)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrPrimerController, decoration: const InputDecoration(labelText: 'R', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _ctsPrimerController, decoration: const InputDecoration(labelText: 'S', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cttPrimerController, decoration: const InputDecoration(labelText: 'T', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Arus CT Sekunder (Ampere)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
           Row(
            children: [
              Expanded(child: TextField(controller: _ctrSekunderController, decoration: const InputDecoration(labelText: 'R', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _ctsSekunderController, decoration: const InputDecoration(labelText: 'S', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cttSekunderController, decoration: const InputDecoration(labelText: 'T', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Ratio CT', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrRatioController, readOnly: true, decoration: const InputDecoration(labelText: 'R', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _ctsRatioController, readOnly: true, decoration: const InputDecoration(labelText: 'S', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cttRatioController, readOnly: true, decoration: const InputDecoration(labelText: 'T', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Error CT', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrErrorController, readOnly: true, decoration: const InputDecoration(labelText: 'R', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _ctsErrorController, readOnly: true, decoration: const InputDecoration(labelText: 'S', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cttErrorController, readOnly: true, decoration: const InputDecoration(labelText: 'T', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Tegangan', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrTeganganController, decoration: const InputDecoration(labelText: 'R', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _ctsTeganganController, decoration: const InputDecoration(labelText: 'S', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: _cttTeganganController, decoration: const InputDecoration(labelText: 'T', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Cosphi', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(controller: _cosphiController, decoration: const InputDecoration(labelText: 'Cosphi', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
