class UpdateUserModel {
  bool? result;
  String? message;
  Data? data;
  String? error;

  UpdateUserModel({this.result, this.message, this.data, this.error});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  User? user;
  Profile? profile;

  Data({this.user, this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    return data;
  }
}

class Profile {
  int? id;
  int? userId;
  String? fullName;
  String? gender;
  String? dateOfBirth;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? idLecturer;
  String? highestEducation;
  String? teachingExperience;
  String? educationHistory;
  String? contactAddress;
  String? shortBio;
  String? imageUrl;

  Profile({
    this.id,
    this.userId,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.idLecturer,
    this.highestEducation,
    this.teachingExperience,
    this.educationHistory,
    this.contactAddress,
    this.shortBio,
    this.imageUrl,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idLecturer = json['id_lecturer'];
    highestEducation = json['highest_education'];
    teachingExperience = json['teaching_experience'];
    educationHistory = json['education_history'];
    contactAddress = json['contact_address'];
    shortBio = json['short_bio'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_lecturer'] = this.idLecturer;
    data['highest_education'] = this.highestEducation;
    data['teaching_experience'] = this.teachingExperience;
    data['education_history'] = this.educationHistory;
    data['contact_address'] = this.contactAddress;
    data['short_bio'] = this.shortBio;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
