import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/customer_model.dart';
import '../services/customer_service.dart';
import '../../auth/services/auth_Services.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CustomerModel> _customers = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Pagination state
  int _currentPage = 1;
  int _lastPage = 1;
  int _total = 0;
  int _perPage = 10;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers({int page = 1}) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      final service = CustomerService();
      final response = await service.getCustomers(
        page: page,
        perPage: _perPage,
        search: _searchQuery.isNotEmpty ? _searchQuery : null,
      );
      setState(() {
        _customers = response.data;
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        _total = response.total;
        _perPage = response.perPage;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _lastPage && page != _currentPage) {
      _fetchCustomers(page: page);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCustomerDetail(CustomerModel customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(customer.nama),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow(label: 'IDPEL', value: customer.idPel.toString(), canCopy: true),
              _DetailRow(label: 'Unit UP', value: customer.unitUp.toString()),
              _DetailRow(label: 'Alamat', value: customer.alamat),
              _DetailRow(label: 'Tarif', value: customer.tarif),
              _DetailRow(label: 'Daya', value: '${customer.daya.toStringAsFixed(0)} VA'),
              _DetailRow(label: 'Merk Meter', value: customer.merkMeter),
              _DetailRow(label: 'No Meter', value: customer.noMeter),
              _DetailRow(label: 'Tahun Meter', value: customer.tahunMeter.toStringAsFixed(0)),
              _DetailRow(label: 'Faktor Kali', value: customer.faktorKaliMeter.toString()),
              if (customer.koordinat.isNotEmpty)
                _DetailRow(label: 'Koordinat', value: customer.koordinat),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gagal memuat data: $_errorMessage'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _fetchCustomers,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            )
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/cekpot');
                        },
                        icon: const Icon(Icons.assignment, size: 18),
                        label: const Text(
                          'CEK POT',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                'Apakah Anda yakin ingin logout?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Logout'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true && context.mounted) {
                            await AuthServices().logout();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (route) => false,
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.logout, size: 18),
                        label: const Text(
                          'LOGOUT',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search and info - responsive layout
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                    _fetchCustomers();
                                  },
                                )
                              : null,
                          border: const OutlineInputBorder(),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          _fetchCustomers();
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Showing ${(_currentPage - 1) * _perPage + 1} to ${(_currentPage * _perPage).clamp(0, _total)} of $_total entries',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Customer List with ListTile
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _customers.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final customer = _customers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              customer.nama.isNotEmpty
                                  ? customer.nama[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            customer.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.numbers,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'IDPEL: ${customer.idPel}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      customer.alamat,
                                      style: const TextStyle(fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  _InfoChip(label: 'Unit: ${customer.unitUp}'),
                                  _InfoChip(label: 'Tarif: ${customer.tarif}'),
                                  _InfoChip(
                                    label:
                                        'Daya: ${customer.daya.toStringAsFixed(0)}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) async {
                              switch (value) {
                                case 'info':
                                  _showCustomerDetail(customer);
                                  break;
                                case 'gmaps':
                                  if (customer.koordinat.isNotEmpty) {
                                    // Perbaiki format koordinat: ganti ". " dengan ","
                                    final cleanKoordinat = customer.koordinat
                                        .replaceAll('. ', ',')
                                        .replaceAll(' ', ',')
                                        .trim();
                                    // Gunakan geo: URI untuk membuka app Maps langsung
                                    final geoUrl = Uri.parse('geo:$cleanKoordinat?q=$cleanKoordinat');
                                    final webUrl = Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=$cleanKoordinat',
                                    );
                                    
                                    if (await canLaunchUrl(geoUrl)) {
                                      await launchUrl(geoUrl);
                                    } else if (await canLaunchUrl(webUrl)) {
                                      await launchUrl(
                                        webUrl,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Koordinat tidak tersedia'),
                                      ),
                                    );
                                  }
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'info',
                                child: ListTile(
                                  leading: Icon(Icons.info, color: Colors.cyan),
                                  title: Text('Info'),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'gmaps',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.map,
                                    color: Colors.orange,
                                  ),
                                  title: Text('Google Maps'),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Pagination Controls
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _currentPage > 1
                              ? () => _goToPage(_currentPage - 1)
                              : null,
                          child: const Text('Previous'),
                        ),
                        const SizedBox(width: 8),
                        ..._buildPageButtons(),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _currentPage < _lastPage
                              ? () => _goToPage(_currentPage + 1)
                              : null,
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildPageButtons() {
    List<Widget> buttons = [];
    int startPage = (_currentPage - 1).clamp(1, _lastPage);
    int endPage = (startPage + 2).clamp(1, _lastPage);

    if (endPage - startPage < 2) {
      startPage = (endPage - 2).clamp(1, _lastPage);
    }

    for (int i = startPage; i <= endPage; i++) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
            onPressed: i != _currentPage ? () => _goToPage(i) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: i == _currentPage
                  ? Colors.blue
                  : Colors.grey[300],
              foregroundColor: i == _currentPage ? Colors.white : Colors.black,
              minimumSize: const Size(40, 36),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text('$i'),
          ),
        ),
      );
    }

    if (endPage < _lastPage) {
      buttons.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('...'),
        ),
      );
      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
            onPressed: () => _goToPage(_lastPage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
              minimumSize: const Size(40, 36),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text('$_lastPage'),
          ),
        ),
      );
    }

    return buttons;
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool canCopy;

  const _DetailRow({
    required this.label,
    required this.value,
    this.canCopy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: SelectableText(
              value.isEmpty ? '-' : value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (canCopy && value.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Salin ke clipboard',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label disalin ke clipboard'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
