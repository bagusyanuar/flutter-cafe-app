import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LoginRequest {
  String username;
  String password;

  LoginRequest({
    required this.username,
    required this.password,
  });
}

class LoginResponse {
  bool error;
  String message;

  LoginResponse({
    required this.error,
    required this.message,
  });
}

Future<LoginResponse> loginController(LoginRequest request) async {
  LoginResponse response = LoginResponse(
    error: true,
    message: "internal server error",
  );
  try {
    await Future.delayed(const Duration(seconds: 2));
    if (request.username == 'admin' && request.password == 'admin') {
      String token = "abcdefg";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", token);
      response = LoginResponse(
        error: false,
        message: "successfully login",
      );
    } else {
      response = LoginResponse(
        error: true,
        message: "password did not match",
      );
    }
  } catch (e) {
    response = LoginResponse(
      error: true,
      message: "internal server error",
    );
    log(e.toString());
  }
  return response;
}
