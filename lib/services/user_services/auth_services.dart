import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:supabase/supabase.dart';

class AuthenticationService {
  Future<String?> registerUser(
      {required String email, required String password}) async {
    GotrueSessionResponse response =
        await SupabaseCredentials.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      print("Register Berhasil");
      String? userEmail = response.data!.user!.email;
      print("Email : $userEmail");
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
