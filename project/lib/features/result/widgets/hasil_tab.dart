import 'package:flutter/material.dart';

class ResultTab extends StatelessWidget {
  const ResultTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hasil Akhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // field text untuk keterangan, kesimpulan, tindak lanjut, petugas pemeriksa
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Keterangan', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Kesimpulan', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tindak Lanjut', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Petugas Pemeriksa', border: OutlineInputBorder())),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simpan Data Pemeriksaan...')),
                );
              },
              child: const Text('Simpan Pemeriksaan', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
