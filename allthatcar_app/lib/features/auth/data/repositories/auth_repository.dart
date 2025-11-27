import 'package:supabase_flutter/supabase_flutter.dart';

/// 인증 저장소
class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  /// 로그인
  Future<Map<String, dynamic>?> login({
    required String account,
    required String password,
  }) async {
    try {
      print('🔍 Login attempt: user_id=$account');

      // 임시 계정 정보 (Supabase 연결 전 테스트용)
      final Map<String, Map<String, dynamic>> mockUsers = {
        'admin': {
          'id': '1',
          'user_id': 'admin',
          'password': '1234',
          'name': '관리자',
          'created_at': DateTime.now().toIso8601String(),
        },
        'test': {
          'id': '2',
          'user_id': 'test',
          'password': 'test123',
          'name': '테스트 유저',
          'created_at': DateTime.now().toIso8601String(),
        },
      };

      // 임시 계정으로 로그인 검증
      if (mockUsers.containsKey(account)) {
        final user = mockUsers[account]!;
        if (user['password'] == password) {
          print('✅ Mock login success: ${user['name']}');
          return {
            'id': user['id'],
            'user_id': user['user_id'],
            'name': user['name'],
            'created_at': user['created_at'],
          };
        }
      }

      print('❌ Invalid credentials');
      return null;

      // TODO: Supabase 연결 후 실제 DB 조회로 교체
      // final response = await _supabase
      //     .from('users')
      //     .select()
      //     .eq('user_id', account)
      //     .eq('password', password)
      //     .maybeSingle();
      // return response;
    } catch (e) {
      print('❌ Login error: $e');
      throw Exception('로그인 중 오류가 발생했습니다: $e');
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    // TODO: 로그아웃 로직 구현 (세션 삭제 등)
  }

  /// 현재 사용자 정보 가져오기
  Future<Map<String, dynamic>?> getCurrentUser() async {
    // TODO: 저장된 사용자 정보 가져오기
    return null;
  }
}
