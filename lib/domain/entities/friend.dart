class Friend {
  final int? id;
  final String name;
  final String last_name;
  final String email;
  final String phone;
  final String? photo;

  Friend({
    this.id,
    required this.name,
    required this.last_name,
    required this.email,
    required this.phone,
    this.photo,
  });
}
