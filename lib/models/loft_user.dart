class LoftUser {
  String firstName;
  String lastName;
  String email;
  String phone;

  LoftUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
  factory LoftUser.fromMap(Map<String, dynamic> json) {
    return LoftUser(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phone: json['phone']);
  }
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': firstName,
      'email': email,
      'phone': phone,
    };
  }
}
