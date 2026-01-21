// class untuk mengubah objek menjadi json dan json menjadi objek(untuk interaksi sama json)
class AccountModel{
    // field
    final int id;
    final String username;
    final String password;
    
    // constructor
    AccountModel({required this.id, required this.username, required this.password});

    // factory constructor
    factory AccountModel.fromJson(Map<String, dynamic> json){
        return AccountModel(
            id: json['id'],
            username: json['username'],
            password: json['password'],
        );
    }

    // method
    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'username': username,
            'password': password,
        };
    }
}