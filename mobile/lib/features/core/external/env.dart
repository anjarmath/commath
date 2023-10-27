import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String? get backendBaseUrl => dotenv.env['BACKEND_BASE_URL'];
  static String? get apiKey => dotenv.env['API_KEY'];
  // Add other configuration values here
}
