class ProtectionModel {
  final String kondisiProteksi;
  final String arusSettingOcr;
  final String waktuSettingOcr;
  final String thermalSettingOcr;

  ProtectionModel({
    required this.kondisiProteksi,
    required this.arusSettingOcr,
    required this.waktuSettingOcr,
    required this.thermalSettingOcr,
  });

  factory ProtectionModel.fromJson(Map<String, dynamic> json) {
    return ProtectionModel(
      kondisiProteksi: json['kond_proteksi'] ?? '',
      arusSettingOcr: json['arus_setting'] ?? '',
      waktuSettingOcr: json['waktu_setting'] ?? '',
      thermalSettingOcr: json['thermal_setting'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kond_proteksi': kondisiProteksi,
      'arus_setting': arusSettingOcr,
      'waktu_setting': waktuSettingOcr,
      'thermal_setting': thermalSettingOcr,
    };
  }
}
