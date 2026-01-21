import 'package:flutter/material.dart';
import 'package:project/features/users/widgets/customer_data_tab.dart';
import 'package:project/features/stanMeter/widgets/meter_data_tab.dart';
import 'package:project/features/CT/widgets/ct_data_tab.dart';
import 'package:project/features/maintenance/widgets/maintenance_tab.dart';
import 'package:project/features/kwh/widgets/kwh_meter_data.dart';
import 'package:project/features/dokumentasi/widgets/documentation_tab.dart';
import 'package:project/features/hasil/widgets/hasil_tab.dart';

import 'package:project/features/auth/services/auth_Services.dart';
import 'package:project/features/auth/screens/login_screen.dart';

class CtInspectionScreen extends StatelessWidget {
  const CtInspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Input Cekpot'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                // Tampilkan konfirmasi logout (opsional) atau langsung logout
                
                // Panggil service logout
                // Karena method logout() di authServices mengembalikan Future<bool>, kita tunggu hasilnya
                final success = await authServices().logout();

                if (context.mounted) {
                   if (success) {
                     // Jika logout sukses (atau dianggap sukses), navigasi ke LoginScreen
                     // Hapus semua route sebelumnya agar user tidak bisa 'back' ke halaman ini
                     Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(builder: (context) => const LoginScreen()),
                       (route) => false,
                     );
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Logout gagal, silakan coba lagi')),
                     );
                   }
                }
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Pelanggan'),
              Tab(text: 'Data KWH Meter'),
              Tab(text: 'Data Stan Meter'),
              Tab(text: 'Pemeriksaan CT'),
              Tab(text: 'Pemeliharaan Proteksi'),
              Tab(text: 'Dokumentasi'),
              Tab(text: 'Hasil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CustomerDataTab(),
            KwhMeterDataTab(),
            MeterDataTab(),
            CtDataTab(),
            MaintenanceTab(),
            DocumentationTab(),
            ResultTab(),
          ],
        ),
      ),
    );
  }
}
