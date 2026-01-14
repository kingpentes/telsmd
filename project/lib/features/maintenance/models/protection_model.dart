class ProtectionModel {
  final String kondisiProteksi;
  final double arusSettingOcr;
  final double waktuSettingOcr;
  final double thermalSettingOcr;

  ProtectionModel({
    required this.kondisiProteksi,
    required this.arusSettingOcr,
    required this.waktuSettingOcr,
    required this.thermalSettingOcr,
  });

  factory ProtectionModel.fromJson(Map<String, dynamic> json) {
    return ProtectionModel(
      kondisiProteksi: json['kondisi_proteksi'] ?? '',
      arusSettingOcr: double.tryParse(json['arus_setting_ocr']?.toString() ?? '') ?? 0.0,
      waktuSettingOcr: double.tryParse(json['waktu_setting_ocr']?.toString() ?? '') ?? 0.0,
      thermalSettingOcr: double.tryParse(json['thermal_setting_ocr']?.toString() ?? '') ?? 0.0,
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
