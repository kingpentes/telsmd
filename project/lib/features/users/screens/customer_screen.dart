import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../services/customer_service.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CustomerModel> _customers = [];
  List<CustomerModel> _filteredCustomers = [];
  bool _isLoading = true;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _fetchCustomers();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchCustomers() async {
    try {
      setState(() { _isLoading = true; _errorMessage = null; });
      final service = CustomerService();
      final customers = await service.getCustomers();
      setState(() {
        _customers = customers;
        _filteredCustomers = customers;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _onSearchChanged() {
    setState(() {
      _filteredCustomers = _customers.where((customer) {
        final query = _searchController.text.toLowerCase();
        return customer.nama.toLowerCase().contains(query) ||
               customer.idPel.toString().contains(query) ||
               customer.alamat.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Induk Pelanggan'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchCustomers,
          ),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : _errorMessage != null
              ? Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Gagal memuat data: $_errorMessage'),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _fetchCustomers, child: const Text('Coba Lagi'))
                  ],
                ))
              : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('TAMBAH DIL BARU', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('DOWNLOAD DIL', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: const Icon(Icons.upload, size: 18),
                  label: const Text('UPLOAD DIL', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Show entries: ${_filteredCustomers.length}'), 
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // DataTable
            SizedBox(
              width: double.infinity,
              child: PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('UNIT', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('IDPEL', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('NAMA', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('ALAMAT', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('TARIF', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('DAYA', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('ACTION', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                source: _CustomerDataSource(_filteredCustomers, context),
                rowsPerPage: 10,
                columnSpacing: 20,
                showCheckboxColumn: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerDataSource extends DataTableSource {
  final List<CustomerModel> _customers;
  final BuildContext _context;

  _CustomerDataSource(this._customers, this._context);

  @override
  DataRow? getRow(int index) {
    if (index >= _customers.length) return null;
    final customer = _customers[index];

    return DataRow(cells: [
      DataCell(Text(customer.unitUp.toString())),
      DataCell(Text(customer.idPel.toString())),
      DataCell(Text(customer.nama)),
      DataCell(Text(customer.alamat)),
      DataCell(Text(customer.tarif)),
      DataCell(Text(customer.daya.toStringAsFixed(0))),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionButton(label: 'Edit', color: Colors.blueAccent, onPressed: () {
          }),
          const SizedBox(width: 4),
          _ActionButton(label: 'Info', color: Colors.cyan, onPressed: () {}),
          const SizedBox(width: 4),
          _ActionButton(label: 'Gmaps', color: Colors.orange, onPressed: () {}),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _customers.length;
  @override
  int get selectedRowCount => 0;
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({required this.label, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          textStyle: const TextStyle(fontSize: 10),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
