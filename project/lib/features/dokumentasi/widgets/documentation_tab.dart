import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../inspection/providers/inspection_provider.dart';
import '../models/documentation_model.dart';

class DocumentationTab extends StatefulWidget {
  const DocumentationTab({super.key});

  @override
  State<DocumentationTab> createState() => _DocumentationTabState();
}

class _DocumentationTabState extends State<DocumentationTab> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // No explicit initialization needed for images as we pull directly from provider in build or helper
    // However, for local display consistency in _images map, we can sync.
    // Actually, sticking to the _images pattern:
  }

  Future<void> _pickImage(String key, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      // Update Provider
      final provider = Provider.of<InspectionProvider>(context, listen: false);
      final currentDoc = provider.documentation;
      
      String? path = pickedFile.path;
      
      provider.updateDocumentation(DocumentationModel(
        fotoKwh: key == 'fotoKwh' ? path : currentDoc.fotoKwh,
        fotoRelay: key == 'fotoRelay' ? path : currentDoc.fotoRelay,
        fotoKubikel: key == 'fotoKubikel' ? path : currentDoc.fotoKubikel,
        fotoHasil1: key == 'fotoHasil1' ? path : currentDoc.fotoHasil1,
        fotoHasil2: key == 'fotoHasil2' ? path : currentDoc.fotoHasil2,
        beritaAcara: key == 'beritaAcara' ? path : currentDoc.beritaAcara,
      ));
      
      setState(() {}); // Trigger rebuild to show new image
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dokumentasi Inspeksi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // grid untuk foto kwh, foto relay, foto kubikel, foto hasil 1, foto hasil 2, berita acara
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
            children: [
              _buildImageInput('Foto KWH', 'fotoKwh'),
              _buildImageInput('Foto Relay', 'fotoRelay'),
              _buildImageInput('Foto Kubikel', 'fotoKubikel'),
              _buildImageInput('Foto Hasil 1', 'fotoHasil1'),
              _buildImageInput('Foto Hasil 2', 'fotoHasil2'),
              _buildImageInput('Berita Acara', 'beritaAcara'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageInput(String label, String key) {
    // Get image path from provider
    final provider = Provider.of<InspectionProvider>(context);
    final doc = provider.documentation;
    String? path;
    
    switch (key) {
      case 'fotoKwh': path = doc.fotoKwh; break;
      case 'fotoRelay': path = doc.fotoRelay; break;
      case 'fotoKubikel': path = doc.fotoKubikel; break;
      case 'fotoHasil1': path = doc.fotoHasil1; break;
      case 'fotoHasil2': path = doc.fotoHasil2; break;
      case 'beritaAcara': path = doc.beritaAcara; break;
    }
    
    final imageFile = (path != null && path.isNotEmpty) ? File(path) : null;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: imageFile != null
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(imageFile,
                                fit: BoxFit.cover, width: double.infinity)),
                      ),
                      IconButton(
                        onPressed: () {
                          // Clear image in provider
                          final currentDoc = provider.documentation;
                           provider.updateDocumentation(DocumentationModel(
                            fotoKwh: key == 'fotoKwh' ? '' : currentDoc.fotoKwh,
                            fotoRelay: key == 'fotoRelay' ? '' : currentDoc.fotoRelay,
                            fotoKubikel: key == 'fotoKubikel' ? '' : currentDoc.fotoKubikel,
                            fotoHasil1: key == 'fotoHasil1' ? '' : currentDoc.fotoHasil1,
                            fotoHasil2: key == 'fotoHasil2' ? '' : currentDoc.fotoHasil2,
                            beritaAcara: key == 'beritaAcara' ? '' : currentDoc.beritaAcara,
                          ));
                        },
                        icon: const Icon(Icons.remove_circle,
                            color: Colors.red),
                      ),
                    ],
                  )
                : Center(
                    child: Icon(Icons.camera_alt,
                        size: 40, color: Colors.grey[400]),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          if (imageFile == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _pickImage(key, ImageSource.camera),
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _pickImage(key, ImageSource.gallery),
                  icon: const Icon(Icons.photo_library, color: Colors.green),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
