import 'package:commath/features/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();

  await initializeDateFormatting('id_ID', null);

  // Load environtment variables
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: Commath()));
}
