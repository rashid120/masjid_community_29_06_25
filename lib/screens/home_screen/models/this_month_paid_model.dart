class ThisMonthPaidModel{
  int? status;
  String? message;
  List<ThisMonthPaid>? data;

  /// docs - ye home screen par dikhega ki is month me kitne log paisa jama kiye hai
  /// https://xyz.com/v1/api/get_all_users?month=current_month      - hint - status = paid ya is_paid=true
  ThisMonthPaidModel({this.status, this.message, this.data});

  factory ThisMonthPaidModel.fromJson(Map<String, dynamic> json){
    return ThisMonthPaidModel(
      status: json['status'],
      message: json['message'],
      data: json['data']
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

class ThisMonthPaid{

  int? id;
  int? userId;
  String? username;
  String? userImage;
  String? amount;
  String? dateTime;
  String? createAt;
  String? updateAt;

  ThisMonthPaid({
    this.id,
    this.userId,
    this.username,
    this.userImage,
    this.amount,
    this.dateTime,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'user_id' : userId,
      'username' : username,
      'user_image' : userImage,
      'amount' : amount,
      'date_time' : dateTime,
      'create_at' : createAt,
      'update_at' : updateAt,
    };
  }

  factory ThisMonthPaid.fromJson(Map<String, dynamic> json) {
    return ThisMonthPaid(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      userImage: json['user_image'],
      amount: json['amount'],
      dateTime: json['date_time'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
    );
  }
}