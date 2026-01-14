// class untuk mengubah objek menjadi json dan json menjadi objek(untuk interaksi sama json)
class usersModel{
    // field
    final int id;
    final String username;
    final String password;
    
    // constructor
    usersModel({required this.id, required this.username, required this.password});

    // factory constructor
    factory usersModel.fromJson(Map<String, dynamic> json){
        return usersModel(
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