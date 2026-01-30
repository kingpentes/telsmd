import 'dart:convert';
import 'dart:io';

class DocumentationModel {
  final String fotoKwh;
  final String fotoRelay;
  final String fotoKubikel;
  final String fotoHasil1;
  final String fotoHasil2;
  final String beritaAcara;

  DocumentationModel({
    required this.fotoKwh,
    required this.fotoRelay,
    required this.fotoKubikel,
    required this.fotoHasil1,
    required this.fotoHasil2,
    required this.beritaAcara,
  });

  factory DocumentationModel.fromJson(Map<String, dynamic> json) {
    return DocumentationModel(
      fotoKwh: json['doku1'] ?? '',
      fotoRelay: json['doku2'] ?? '',
      fotoKubikel: json['doku3'] ?? '',
      fotoHasil1: json['doku4'] ?? '',
      fotoHasil2: json['doku5'] ?? '',
      beritaAcara: json['dokumen'] ?? '',
    );
  }

  Future<String> _imageToBase64(String imagePath) async {
    if (imagePath.isEmpty) return '';
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        return base64Encode(bytes);
      }
    } catch (e) {
      print('Error converting image to base64: $e');
    }
    return '';
  }

  /// toJson untuk penyimpanan lokal (menyimpan path file)
  Map<String, dynamic> toJson() {
    return {
      'doku1': fotoKwh,
      'doku2': fotoRelay,
      'doku3': fotoKubikel,
      'doku4': fotoHasil1,
      'doku5': fotoHasil2,
      'dokumen': beritaAcara,
    };
  }

  /// toJson untuk mengirim ke API
  Future<Map<String, dynamic>> toJsonWithBase64() async {
    return {
      'doku1': await _imageToBase64(fotoKwh),
      'doku2': await _imageToBase64(fotoRelay),
      'doku3': await _imageToBase64(fotoKubikel),
      'doku4': await _imageToBase64(fotoHasil1),
      'doku5': await _imageToBase64(fotoHasil2),
      'dokumen': await _imageToBase64(beritaAcara),
    };
  }
}
