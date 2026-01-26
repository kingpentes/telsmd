// class untuk mengubah objek menjadi json dan json menjadi objek(untuk interaksi sama json)
class AccountModel {
  // field
  final int? id;
  final String? username;
  final String? name;
  final String? token;

  // constructor
  AccountModel({this.id, this.username, this.name, this.token});

  // factory constructor, method fromJson
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    // Response format: { "success": true, "data": { "token": "...", "username": "...", ... } }
    if (json.containsKey('data') && json['data'] != null) {
      final data = json['data'] as Map<String, dynamic>;
      return AccountModel(
        id: data['id'],
        username: data['username']?.toString(),
        name: data['name']?.toString(),
        token: data['token']?.toString(),
      );
    }

    // Fallback: token di root level
    return AccountModel(
      id: json['id'],
      username: json['username']?.toString(),
      name: json['name']?.toString(),
      token: json['token']?.toString(),
    );
  }

  // method toJson
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'name': name, 'token': token};
  }
}
