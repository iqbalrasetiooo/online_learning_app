class IsWatchedModel {
  bool? result;
  String? message;
  List<Data>? data;
  String? error;

  IsWatchedModel({this.result, this.message, this.data, this.error});

  IsWatchedModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      if (json['data'] is List) {
        for (var v in json['data']) {
          data!.add(Data.fromJson(v));
        }
      } else if (json['data'] is Map<String, dynamic>) {
        data!.add(Data.fromJson(json['data']));
      }
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  int? videoId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? status;

  Data({this.id, this.videoId, this.userId, this.createdAt, this.updatedAt, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_id'] = this.videoId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
