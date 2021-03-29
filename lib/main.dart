import 'package:e_commerce/layout/home.dart';
import 'package:e_commerce/modules/dashboard/cubit/cubit.dart';
import 'package:e_commerce/modules/splash/splash_screen.dart';
import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/commponents/constants.dart';
import 'package:e_commerce/shared/di/di.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
   userToken = await getUserToken();

  Widget start;

  if(userToken != null)
  {
    start = HomeScreen();
  }
  else
    {
      start = SplashScreen();
    }
  runApp(MyApp(start: start,));
}

class MyApp extends StatelessWidget {
  final Widget start;

  MyApp({this.start}); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<DashboardCubit>()..getHomeData()..getCategories()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Muli',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: kTextColor,
            ),
            bodyText2: TextStyle(
              color: kTextColor,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: start,
      ),
    );
  }
}
