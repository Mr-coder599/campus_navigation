class UserReg {
  late final String uid;
  late final String fullname;
  late final String gender;
  late final String phoneNo;
  late final String position;
  late final String email;
  late final String password;

  UserReg({
    required this.uid,
    required this.fullname,
    required this.gender,
    required this.phoneNo,
    required this.position,
    required this.email,
    required this.password,
  });

  factory UserReg.froJson(Map<String, dynamic> json) {
    return UserReg(
      uid: json['uid'],
      fullname: json['fullname'],
      gender: json['gender'],
      phoneNo: json['phoneNo'],
      position: json['position'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'gender': gender,
      'phoneNo': phoneNo,
      'position': position,
      'email': email,
      'password': password,
    };
  }
}

// ignore: camel_case_types
