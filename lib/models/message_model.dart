class MessageModel {
  String? receiverId;
  String? senderId;
  String? dateTime;
  String? text;

  MessageModel({
    this.receiverId,
    this.text,
    this.senderId,
    this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
