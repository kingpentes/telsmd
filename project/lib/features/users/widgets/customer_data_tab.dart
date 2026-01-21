import 'package:flutter/material.dart';

class CustomerDataTab extends StatelessWidget {
  const CustomerDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Data Pelanggan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'ID Pelanggan', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Unit Up', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Nama Pelanggan', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Alamat', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tarif', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Daya', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Merk Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'No Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Tahun Meter', border: OutlineInputBorder())),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Faktor Kali Meter', border: OutlineInputBorder())),
        ],
      ),
    );
  }
}
