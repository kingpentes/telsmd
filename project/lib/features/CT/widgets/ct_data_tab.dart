import 'package:flutter/material.dart';

class CtDataTab extends StatelessWidget {
  const CtDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Data Pengukuran CT',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'PT Terpasang', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'CT Terpasang', border: OutlineInputBorder())),
          SizedBox(height: 24),
          Text('Arus CT Primer (Ampere)', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'R', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'S', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'T', border: OutlineInputBorder()))),
            ],
          ),
          SizedBox(height: 16),
          Text('Arus CT Sekunder (Ampere)', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
           Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'R', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'S', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'T', border: OutlineInputBorder()))),
            ],
          ),
          SizedBox(height: 16),
          Text('Ratio CT', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'R', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'S', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'T', border: OutlineInputBorder()))),
            ],
          ),
          SizedBox(height: 16),
          Text('Error CT', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'R', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'S', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'T', border: OutlineInputBorder()))),
            ],
          ),
          SizedBox(height: 16),
          Text('Tegangan', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'R', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'S', border: OutlineInputBorder()))),
              SizedBox(width: 8),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'T', border: OutlineInputBorder()))),
            ],
          ),
          SizedBox(height: 16),
          Text('Cosphi', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          TextField(decoration: InputDecoration(labelText: 'Cosphi', border: OutlineInputBorder())),
          // Add other fields from CtInspectionModel as needed
        ],
      ),
    );
  }
}
