class FriendModel {
  final int? id;
  final String name;
  final String last_name;
  final String email;
  final String phone;
  final String? photo;

  FriendModel({
    this.id,
    required this.name,
    required this.last_name,
    required this.email,
    required this.phone,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'photo': photo,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      id: map['id'],
      name: map['name'],
      last_name: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
    );
  }
}
