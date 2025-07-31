class UserModelData{

  int? status;
  String? message;
  List<UsersModel>? data;

  /// docs - all users ke data sabhi user ko dekhne ke liye ki kon paid kiya hai kon nhi
  /// https://xyz.com/v1/api/get_all_users?month=$month&status=$status  = month - jan 25 . status - paid, unpaid, all
  UserModelData({this.status, this.message, this.data});

  factory UserModelData.fromJson(Map<String, dynamic> json){
    return UserModelData(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'status' : status,
      'message' : message,
      'data' : data,
    };
  }
}

class UsersModel {
  int? id;
  String? userId;
  String? name;
  String? monthName;
  int? amount;
  bool? isPaid;
  String? profileImageUrl;

  UsersModel({
    this.id,
    this.userId,
    this.name,
    this.monthName,
    this.amount,
    this.isPaid,
    this.profileImageUrl,
  });

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'] as String?,
      monthName: map['month_name'] as String?,
      amount: map['amount'] as int?,
      isPaid: map['is_paid'] as bool?,
      profileImageUrl: map['profile_image'],
    );
  }
}