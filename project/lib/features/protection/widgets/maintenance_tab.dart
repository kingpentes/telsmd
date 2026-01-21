import 'package:flutter/material.dart';

class MaintenanceTab extends StatelessWidget {
  const MaintenanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Pemeliharaan Proteksi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // TODO: Add form fields for Customer Data here
          TextField(decoration: InputDecoration(labelText: 'Kondisi Proteksi', border: OutlineInputBorder())),
          SizedBox(height: 16),// belum diubah dropdown
          TextField(decoration: InputDecoration(labelText: 'Arus Setting OCR', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Waktu Setting OCR', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Thermal Setting OCR', border: OutlineInputBorder())),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
