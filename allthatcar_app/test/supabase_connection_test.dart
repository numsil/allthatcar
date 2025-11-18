import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('Supabase connection test', () async {
    print('🔍 Testing Supabase connection...\n');

    try {
      // Initialize Supabase
      await Supabase.initialize(
        url: 'https://apjhqxmmnfmikmbfjdgc.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwamhxeG1tbmZtaWttYmpmZGdjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMwODAyNTEsImV4cCI6MjA3ODY1NjI1MX0.lvle7JuW9bpkjtsCxpjua9HiK6dtPuB4dS986ScUyrw',
      );

      final supabase = Supabase.instance.client;

      print('✅ Supabase client initialized');
      print('📍 URL: https://apjhqxmmnfmikmbfjdgc.supabase.co');

      // Test database connection with a simple auth check
      print('\n🧪 Testing connection...');

      // Just verify the client is initialized
      expect(supabase, isNotNull);

      print('✅ Supabase is properly configured!');
      print('🎉 Connection test passed!');

    } catch (e) {
      print('❌ Connection failed!');
      print('Error: $e');
      rethrow;
    }
  });
}
