class DuePaymentModel{

  int? status;
  String? message;
  List<DuePayment>? data;

  /// docs - har user ke home screen par yah api call hoga user_id ke base par
  /// https://axy.com/v1/api/due_payment?user_id=0       - hint - is_paid=false
  DuePaymentModel({this.status, this.message, this.data});

  factory DuePaymentModel.fromJson(Map<String, dynamic> json){
    return DuePaymentModel(
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

class DuePayment{
  int? id;
  int? userId;
  String? months;
  String? amount;
  bool? isPaid;
  String? dueFrom;
  String? totalDue;
  String? createAt;
  String? updateAd;

  DuePayment({this.id, this.userId, this.months, this.amount, this.isPaid, this.dueFrom, this.totalDue, this.createAt, this.updateAd});

  factory DuePayment.fromJson(Map<String, dynamic> json){
    return DuePayment(
      id: json['id'],
      userId: json['user_id'],
      months: json['month_name'],
      amount: json['amount'],
      isPaid: json['is_paid'],
      dueFrom: json['due_from'],
      totalDue: json['total_due'],
      createAt: json['create_at'],
      updateAd: json['update_at'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'user_id' : userId,
      'month_name' : months,
      'amount' : amount,
      'is_paid' : isPaid,
      'due_from' : dueFrom,
      'total_due' : totalDue,
      'create_at' : createAt,
      'update_at' : updateAd,
    };
  }
}