import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:supabase/supabase.dart';

import '../../models/user_model/user_model.dart';

import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<String?> registerUser(
      {required String email, required String password}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      print("Register Berhasil");
      String? id = response.data!.user!.id;
      return id;
    } else {
      print("Register Gagal");
      print(response.error!.message);
    }
  }

  Future<String?> loginUser(
      {required String email, required String password}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SupabaseCredentials.urlProject));

    if (response.error == null) {
      print("Login Berhasil");
      String? id = response.data!.user!.id;
      return id;
    } else {
      print("Login Gagal");
      print(response.error!.message);
    }
  }

  Future<void> logOut() async {
    await SupabaseCredentials.supabaseClient.auth.signOut();
  }
}

Future<http.Response?> registerUserData(UserModel data) async {
  http.Response? respone;
  try {
    respone = await http.post(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?apikey=$apiKey'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.toJson()));
        
  } catch (e) {
    debugPrint(e.toString());
  }
  return respone;
}
