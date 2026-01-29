import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/features/users/widgets/customer_data_tab.dart';
import 'package:project/features/stanMeter/widgets/meter_data_tab.dart';
import 'package:project/features/CT/widgets/ct_data_tab.dart';
import 'package:project/features/protection/widgets/maintenance_tab.dart';
import 'package:project/features/kwh/widgets/kwh_meter_data.dart';
import 'package:project/features/dokumentasi/widgets/documentation_tab.dart';
import 'package:project/features/result/widgets/hasil_tab.dart';
import 'package:project/features/auth/services/auth_Services.dart';
import '../providers/inspection_provider.dart';

class CekpotScreen extends StatelessWidget {
  const CekpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InspectionProvider(),
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Input Cekpot'),
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                tooltip: 'Offline Backlog',
                onPressed: () {
                  Navigator.pushNamed(context, '/backlog');
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final success = await AuthServices().logout();

                  if (context.mounted) {
                    if (success) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logout gagal, silakan coba lagi'),
                        ),
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
      ),
    );
  }
}
