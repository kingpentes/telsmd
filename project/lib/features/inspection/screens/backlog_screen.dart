import 'package:flutter/material.dart';
import '../../inspection/services/inspection_service.dart';
import '../../../core/database/db_helper.dart';

class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key});

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  final InspectionService _inspectionService = InspectionService();
  final DbHelper _dbHelper = DbHelper();
  List<Map<String, dynamic>> _backlogItems = [];
  bool _isLoading = true;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadBacklog();
  }

  Future<void> _loadBacklog() async {
    setState(() => _isLoading = true);
    final items = await _dbHelper.getUnsyncedInspectionsMaps();
    setState(() {
      _backlogItems = items;
      _isLoading = false;
    });
  }

  Future<void> _sync() async {
    setState(() => _isSyncing = true);
    
    await _inspectionService.syncBacklog();
    await _loadBacklog();
    setState(() => _isSyncing = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync completed. Remaining items: ${_backlogItems.length}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Backlog'),
        actions: [
          if (_backlogItems.isNotEmpty)
            IconButton(
              icon: _isSyncing 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                  : const Icon(Icons.sync),
              onPressed: _isSyncing ? null : _sync,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _backlogItems.isEmpty
              ? const Center(child: Text('No pending inspections.'))
              : ListView.builder(
                  itemCount: _backlogItems.length,
                  itemBuilder: (context, index) {
                    final item = _backlogItems[index];
                    return ListTile(
                      leading: const Icon(Icons.pending_actions),
                      title: Text(item['nama'] ?? 'Unknown Customer'),
                      subtitle: Text('ID Pel: ${item['idpel_id'] ?? '-'}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                           // Allow manual delete
                           await _dbHelper.deleteInspection(item['local_id']);
                           _loadBacklog();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
