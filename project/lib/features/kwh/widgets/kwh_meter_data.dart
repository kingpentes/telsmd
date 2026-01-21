import 'package:flutter/material.dart';

class KwhMeterDataTab extends StatelessWidget {
  const KwhMeterDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Data KWH Meter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // field text untuk merk meter, type meter, no seri meter, tegangan meter, arus meter, konstanta meter, tahun meter, class meter, kubikel / mccb
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Merk Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Type Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'NO Seri Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tegangan Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Arus Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Konstanta Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tahun Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Class Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Kubikel / MCCB', border: OutlineInputBorder())),
        ],
      ),
    );
  }
}
