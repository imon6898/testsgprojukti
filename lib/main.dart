import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testsgprojukti/services/network/http_requests.dart';
import 'package:testsgprojukti/view/distributors/category_list_screen.dart';
import 'package:testsgprojukti/view/distributors/group_list_screen.dart';
import 'package:testsgprojukti/view/distributors/group_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpRequests.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Savoy BD',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
      //  textTheme: TextTheme(labelMedium: TextStyle(color: Colors.white)),
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GroupListScreen(),
      // home: HttpRequests.isLogin ? HttpRequests.isWorking ? const HomeScreenBeta() : const StartWorkingScreen() : const LoginScreen(),
    );
  }
}
