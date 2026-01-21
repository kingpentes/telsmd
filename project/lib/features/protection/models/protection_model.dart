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
      kondisiProteksi: json['kondisi_proteksi'] ?? '',
      arusSettingOcr: json['arus_setting_ocr'] ?? '',
      waktuSettingOcr: json['waktu_setting_ocr'] ?? '',
      thermalSettingOcr: json['thermal_setting_ocr'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kondisi_proteksi': kondisiProteksi,
      'arus_setting_ocr': arusSettingOcr,
      'waktu_setting_ocr': waktuSettingOcr,
      'thermal_setting_ocr': thermalSettingOcr,
    };
  }
}
