class UserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;

  UserModel(
      {required this.name,
      this.email,
      this.uId,
      required this.phone,
      required this.isEmailVerified,
      this.bio,
      this.cover,
      this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'cover': cover,
      'bio': bio,
      'image': image,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
