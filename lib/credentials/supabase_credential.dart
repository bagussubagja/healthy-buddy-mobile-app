

import 'package:supabase/supabase.dart';

const String apiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhscnZxaHFudHJycWpkYmNicXhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjY2MjQ3NzgsImV4cCI6MTk4MjIwMDc3OH0.TmGCDNfCImVhbAlaJNUb9pEUyRH5E08ymz5UFijwteo';
const String bearer =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhscnZxaHFudHJycWpkYmNicXhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjY2MjQ3NzgsImV4cCI6MTk4MjIwMDc3OH0.TmGCDNfCImVhbAlaJNUb9pEUyRH5E08ymz5UFijwteo';

class SupabaseCredentials {
  static const String urlProject = 'https://hlrvqhqntrrqjdbcbqxr.supabase.co';
  static SupabaseClient supabaseClient = SupabaseClient(urlProject, apiKey);
}
