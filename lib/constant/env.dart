import 'package:online_learning_app/constant/base_env.dart';

class AppConstants {
  String _baseUrl = "";

  String _apiKey = "";
  String _secretKey = "";
  String _clientID = "";
  String _clientSecret = "";
  String bluApiKey = "";

  String _mobileID = "";
  String _mobileSecret = "";

  String get baseUrl => _baseUrl;
  String get mobileID => _mobileID;
  String get mobileSecret => _mobileSecret;

  // API EMASKITA
  String get apiKey => _apiKey;
  String get secretKey => _secretKey;
  String get clientID => _clientID;
  String get clientSecret => _clientSecret;

  AppConstants() {
    switch (environmentMode) {
      case 'dev':
        {}
        break;
      case 'test':
        {
          _baseUrl = "http://192.168.43.118:8000/api";
          _mobileID = "";
          _mobileSecret = "";

          _apiKey = '';
          _secretKey = '';
          _clientID = '';
          _clientSecret = '';
        }
        break;
      case 'prod':
        {}
        break;
      default:
        {}
        break;
    }
  }
}
