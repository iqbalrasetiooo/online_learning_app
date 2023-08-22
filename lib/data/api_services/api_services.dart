import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_learning_app/constant/env.dart';
import 'package:online_learning_app/data/helper.dart';

import '../../export.dart';
import '../models/app/user_model.dart';

class ApiServices {
  _postData({required String relativeUrl, Map<String, dynamic>? body}) async {
    var url = Uri.parse(AppConstants().baseUrl + relativeUrl);

    var response = await http.post(url, body: body);

    print('Api POST to:$url');
    print(response.body);
    print(response.statusCode);
    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return data;
    } else {
      return throw Exception();
    }
  }

  getData({required String relativeUrl}) async {
    var url = Uri.parse(AppConstants().baseUrl + relativeUrl);

    http.Response response = await http.get(url);
    print('Api GET to:$url');
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      return throw Exception();
    }
  }

  Future getCategories() async {
    return await getData(relativeUrl: '/categories');
  }

  Future getVideoById({required String id}) async {
    return await getData(relativeUrl: '/video/$id');
  }

  Future getCourseByIdLecturer({required String id}) async {
    return await getData(relativeUrl: '/course/lecturer/$id');
  }

  Future deleteCourse({required String id}) async {
    return await _postData(
      relativeUrl: '/course/$id',
      body: {"id": id},
    );
  }

  Future deleteUser({required String id}) async {
    return await _postData(
      relativeUrl: '/user/$id',
      body: {"id": id},
    );
  }

  Future createWatch({required String videoId}) async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    String userId = appUserModel.idUser;
    return await _postData(
      relativeUrl: '/watch',
      body: {
        "video_id": videoId,
        "user_id": userId,
      },
    );
  }

  Future deleteVideo({required String id}) async {
    return await _postData(
      relativeUrl: '/course/video/$id',
      body: {"id": id},
    );
  }

  Future getUserJoinedCourse({required String id}) async {
    return await getData(relativeUrl: '/course/$id/joined-courses');
  }

  Future getCourses() async {
    return await getData(relativeUrl: '/courses');
  }

  Future searchCourse({required String query}) async {
    return await getData(relativeUrl: '/course/search?query=$query');
  }

  Future updateUser({
    required String id,
    String gender = '',
    String dateOfBirth = '',
    String bio = '',
    String imgUrl = '',
    String fullName = '',
    String username = '',
  }) async {
    var body = {
      "gender": gender,
      "full_name": fullName,
      "name": username,
      "date_of_birth": dateOfBirth,
      "short_bio": bio,
      "imageUrl": imgUrl,
    };
    print(body);
    return await _postData(relativeUrl: '/user/$id', body: body);
  }

  Future getUser() async {
    return await getData(relativeUrl: '/users');
  }

  Future addVideo({
    required String courseId,
    required String authorId,
    required String videoUrl,
    required String title,
  }) async {
    var body = {
      "title": title,
      "course_id": courseId,
      "author_id": authorId,
      "video": videoUrl,
    };
    print(body);
    return await _postData(relativeUrl: '/video/add', body: body);
  }

  Future getVideoByCourseIdAndAuthorId({required String id}) async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    String userId = appUserModel.idUser;
    return await getData(relativeUrl: '/course/video/$id');
  }

  Future getWatchedVideos({required String videoId}) async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    String userId = appUserModel.idUser;
    return await _postData(relativeUrl: '/watched', body: {
      "video_id": videoId,
      "user_id": userId,
    });
  }

  Future register({
    required String email,
    required String password,
    required String fullName,
    required String role,
    String userName = '',
    String dateBirth = '',
    String gender = '',
  }) async {
    var body = {
      "username": userName,
      "email": email,
      "password": password,
      "date_of_birth": dateBirth,
      "role": role,
      "gender": gender,
      "full_name": fullName,
    };
    print(body);
    return await _postData(relativeUrl: '/register', body: body);
  }

  Future registerLecturer({
    required String email,
    required String password,
    required String fullName,
    String userName = '',
    String dateBirth = '',
    String gender = '',
    String highestEducation = '',
    String teachingExperience = '',
    String educationHistory = '',
    String contactAddress = '',
    String shortBio = '',
    String imageUrl = '',
  }) async {
    var body = {
      "username": userName,
      "email": email,
      "password": password,
      "date_of_birth": dateBirth,
      "gender": gender,
      "full_name": fullName,
      // "id_lecturer": "LEC${HelperFunction().generateRandomNumber(5)}",
      "highest_education": highestEducation,
      "teaching_experience": teachingExperience,
      "education_history": educationHistory,
      "contact_address": contactAddress,
      "short_bio": shortBio,
      "imageUrl": imageUrl,
    };
    print(body);
    return await _postData(relativeUrl: '/register/lecturer', body: body);
  }

  Future login({
    required String emailOrUsername,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      "email_or_username": emailOrUsername,
      "password": password,
    };
    print(body);
    return await _postData(relativeUrl: '/login', body: body);
  }

  Future addCategory({required String name}) async {
    return await _postData(relativeUrl: '/course/category/add', body: {"name": name});
  }

  Future addCourse({
    required String categoryId,
    required String title,
    required String desc,
    required String image,
    required String memberId,
  }) async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    Map<String, dynamic> body = {
      'author_id': appUserModel.idUser,
      'category_id': categoryId,
      'title': title,
      'member_id': memberId,
      'description': desc,
      'image': image,
    };
    print(body);
    return await _postData(relativeUrl: '/', body: body);
  }

  Future joinCourse({
    required String courseId,
    required String joinedAt,
  }) async {
    String? user = await storage.readData('user');
    UserModelStorage appUserModel = UserModelStorage.deserialize(user!);
    Map<String, dynamic> body = {
      'user_id': appUserModel.idUser,
      'course_id': courseId,
      'joined_at': joinedAt,
    };
    print(body);
    print("ID USER : ${appUserModel.idUser}");
    return await _postData(relativeUrl: '/course/$courseId/join', body: body);
  }
}
