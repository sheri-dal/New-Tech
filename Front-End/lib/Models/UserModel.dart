import '../Helper/Database/BaseDatabase.dart';

class UserModel extends BaseModel<int> {
  @override
  int? id;
  String? userName;
  String? password;
  String? email;
  String? firstName;
  String? lastName;
  UserModel({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.firstName,
    this.lastName,
  });

  UserModel copyWith({
    int? id,
    String? userName,
    String? password,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      userName: map['userName'],
      password: map['password'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }
  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, password: $password, email: $email, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.userName == userName &&
        other.password == password &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        password.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode;
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
