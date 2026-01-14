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
      fotoKwh: json['foto_kwh'] ?? '',
      fotoRelay: json['foto_relay'] ?? '',
      fotoKubikel: json['foto_kubikel'] ?? '',
      fotoHasil1: json['foto_hasil_1'] ?? '',
      fotoHasil2: json['foto_hasil_2'] ?? '',
      beritaAcara: json['berita_acara'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foto_kwh': fotoKwh,
      'foto_relay': fotoRelay,
      'foto_kubikel': fotoKubikel,
      'foto_hasil_1': fotoHasil1,
      'foto_hasil_2': fotoHasil2,
      'berita_acara': beritaAcara,
    };
  }
}
