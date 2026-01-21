import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentationTab extends StatefulWidget {
  const DocumentationTab({super.key});

  @override
  State<DocumentationTab> createState() => _DocumentationTabState();
}

class _DocumentationTabState extends State<DocumentationTab> {
  final ImagePicker _picker = ImagePicker();

  final Map<String, File?> _images = {
    'fotoKwh': null,
    'fotoRelay': null,
    'fotoKubikel': null,
    'fotoHasil1': null,
    'fotoHasil2': null,
    'beritaAcara': null,
  };

  Future<void> _pickImage(String key, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images[key] = File(pickedFile.path);
      });
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
    final imageFile = _images[key];
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
                          setState(() {
                            _images[key] = null;
                          });
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
