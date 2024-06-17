import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supervisor_smile/core/core.dart';
import 'package:supervisor_smile/feautre/feaure.dart';

SharedPreferences? sharedpref;
late bool checkStart;
late bool checkLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  var value = sharedpref!.getString("pref");
  if (value != null) {
    checkStart = false;
  } else {
    checkStart = true;
  }
  var val = sharedpref!.getString(CHARED_DATA_STORAGE);
  if (val != null) {
    checkLogin = false;
  } else {
    checkLogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          theme: themeLight(context),
          builder: (context, myWidget) {
            myWidget = EasyLoading.init()(context, myWidget);
            return myWidget;
          },
          debugShowCheckedModeBanner: false,
          title: 'Smile Care',
          home: checkStart
              ? OnBoarding()
              : checkLogin
                  ? SignIn()
                  : HomeView(),
        );
      },
    );
  }
}
