import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'supabase_config.dart';

class AppConfig {
  static Future<void> initialize() async {
    // Load environment variables
    await dotenv.load(fileName: '.env');

    // Initialize Supabase
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
  }

  static SupabaseClient get supabase => Supabase.instance.client;
}
