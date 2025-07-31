
class LeadersProfileModel{
  int? status;
  String? message;
  List<LeadersProfile>? data;

  /// docs -
  /// https://xyz.com/v1/api/get_leaders_profile
  LeadersProfileModel({
    this.status,
    this.message,
    this.data
  });

  factory LeadersProfileModel.fromJson(Map<String, dynamic> json){
    return LeadersProfileModel(
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

class LeadersProfile {
  int? id;
  int? userId;
  String? name;
  String? image;
  String? position;
  String? about;
  String? createAt;
  String? updateAt;

  LeadersProfile({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.position,
    this.about,
    this.createAt,
    this.updateAt,
  });

  factory LeadersProfile.fromJson(Map<String, dynamic> json) {
    return LeadersProfile(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      image: json['image'],
      position: json['position'],
      about: json['about'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'image': image,
      'position': position,
      'about': about,
      'create_at': createAt,
      'update_at': updateAt,
    };
  }
}
