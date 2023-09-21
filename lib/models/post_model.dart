class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel(
      {required this.name,
      this.text,
      this.uId,
      this.dateTime,
      this.postImage,
      this.image});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    image = json['image'];
    text = json['text'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'dateTime': dateTime,
      'postImage': postImage,
      'image': image,
      'uId': uId,
    };
  }
}
