import 'package:flutter/material.dart';

class MeterDataTab extends StatelessWidget {
  const MeterDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Data Meter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // field text untuk nomor meter, merk meter, tahun pembuatan, stand meter saat ini
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Nomor Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Merk Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tahun Pembuatan', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Stand Meter Saat Ini', border: OutlineInputBorder())),
        ],
      ),
    );
  }
}
