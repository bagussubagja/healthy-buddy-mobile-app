// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:supabase/supabase.dart';

import '../../models/user_model/user_model.dart';

import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<String?> registerUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      String? id = response.data!.user!.id;
      return id;
    } else {
      if (response.error?.message == "User already registered") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Tidak bisa melakukan registrasi : Email sudah terdaftar!")));
        
      }
    }
    return '';
  }

  Future<String?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SupabaseCredentials.urlProject));

    if (response.error == null) {
      String? id = response.data!.user!.id;
      return id;
    } else {
      if (response.error?.message == "Invalid login credentials") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Periksa kembali email atau password yang kamu masukkan!")));
      }
    }
    return '';
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
