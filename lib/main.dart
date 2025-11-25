import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/bindings/initial_bindings.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(const TutorU());
}

class TutorU extends StatelessWidget {
  const TutorU({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TutorU',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.pages,
    );
  }
}
