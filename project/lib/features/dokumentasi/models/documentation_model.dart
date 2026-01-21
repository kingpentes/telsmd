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
}
