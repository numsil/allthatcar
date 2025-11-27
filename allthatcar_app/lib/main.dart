import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'core/config/app_config.dart';
import 'core/config/supabase_config.dart';
import 'core/constants/app_constants.dart';
import 'core/widgets/custom_loading_indicator.dart';
import 'core/widgets/loading_test_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration (Supabase, etc.)
  try {
    await AppConfig.initialize();
    print('✅ Supabase 초기화 성공');
  } catch (e) {
    print('❌ Supabase 초기화 실패: $e');
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // home: const SplashScreen(), // 스플래시 화면
      home: const LoginScreen(), // 로그인 화면 테스트
      // home: const LoadingTestScreen(), // 로딩 테스트 화면
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    // 로딩 애니메이션을 보여주기 위한 지연 (3초)
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: CustomLoadingIndicator(),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version ${AppConstants.appVersion}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 48),
            Icon(
              SupabaseConfig.isConfigured
                  ? Icons.check_circle
                  : Icons.error,
              color: SupabaseConfig.isConfigured
                  ? Colors.green
                  : Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              SupabaseConfig.isConfigured
                  ? '✅ Supabase 연결됨'
                  : '❌ Supabase 연결 실패',
              style: TextStyle(
                color: SupabaseConfig.isConfigured
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
