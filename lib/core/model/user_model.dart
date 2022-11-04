class UserModel {
  String? userName;
  UserModel({required this.userName});
//data from server
  factory UserModel.fromMap(map) {
    return UserModel(userName: map['fawad']);
  }

  //sending  data
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
    };
  }
}
