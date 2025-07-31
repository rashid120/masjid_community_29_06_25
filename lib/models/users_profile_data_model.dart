class UsersProfileDataModel {
  final String? userId;
  final String? userName;
  final String? userImage;
  final bool? isMember;
  final bool? isVerified;
  final List<MonthPayment>? paidMonths;
  final List<MonthPayment>? unpaidMonths;
  final List<EventPayment>? eventPayments;
  final double? totalPaidAmount;
  final double? totalDueAmount;
  final double? totalEventPaidAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UsersProfileDataModel({
    this.userId,
    this.userName,
    this.userImage,
    this.isMember,
    this.isVerified,
    this.paidMonths,
    this.unpaidMonths,
    this.eventPayments,
    this.totalPaidAmount,
    this.totalDueAmount,
    this.totalEventPaidAmount,
    this.createdAt,
    this.updatedAt,
  });

  factory UsersProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UsersProfileDataModel(
      userId: json['userId'],
      userName: json['userName'],
      userImage: json['userImage'],
      isMember: json['isMember'],
      isVerified: json['isVerified'],
      paidMonths: (json['paidMonths'] as List<dynamic>?)
          ?.map((e) => MonthPayment.fromJson(e))
          .toList(),
      unpaidMonths: (json['unpaidMonths'] as List<dynamic>?)
          ?.map((e) => MonthPayment.fromJson(e))
          .toList(),
      eventPayments: (json['eventPayments'] as List<dynamic>?)
          ?.map((e) => EventPayment.fromJson(e))
          .toList(),
      totalPaidAmount: (json['totalPaidAmount'] as num?)?.toDouble(),
      totalDueAmount: (json['totalDueAmount'] as num?)?.toDouble(),
      totalEventPaidAmount: (json['totalEventPaidAmount'] as num?)?.toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'isMember': isMember,
      'isVerified': isVerified,
      'paidMonths': paidMonths?.map((e) => e.toJson()).toList(),
      'unpaidMonths': unpaidMonths?.map((e) => e.toJson()).toList(),
      'eventPayments': eventPayments?.map((e) => e.toJson()).toList(),
      'totalPaidAmount': totalPaidAmount,
      'totalDueAmount': totalDueAmount,
      'totalEventPaidAmount': totalEventPaidAmount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class MonthPayment {
  final String? monthName; // eg. "January"
  final double? amount;
  final bool? isPaid;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MonthPayment({
    this.monthName,
    this.amount,
    this.isPaid,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MonthPayment.fromJson(Map<String, dynamic> json) {
    return MonthPayment(
      monthName: json['monthName'],
      amount: (json['amount'] as num?)?.toDouble(),
      isPaid: json['isPaid'],
      description: json['description'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthName': monthName,
      'amount': amount,
      'isPaid': isPaid,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class EventPayment {
  final String? eventName;
  final String? description;
  final double? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventPayment({
    this.eventName,
    this.description,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory EventPayment.fromJson(Map<String, dynamic> json) {
    return EventPayment(
      eventName: json['eventName'],
      description: json['description'],
      amount: (json['amount'] as num?)?.toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'description': description,
      'amount': amount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
