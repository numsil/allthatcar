class AppConstants {
  // App Info
  static const String appName = 'AllThatCar';
  static const String appVersion = '1.0.0';

  // API Endpoints (Supabase)
  // Add your API endpoints here as needed

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';

  // Routes
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';

  // Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);

  // Pagination
  static const int defaultPageSize = 20;
}
