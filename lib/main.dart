
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/blocobserver.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/shoplayout.dart';
import 'package:shop/modules/login/loginscreen.dart';
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/modules/register/registerscreen.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = new MyHttpOverrides();
  await CacheHelper.init();
  DioHelper.init();
  bool onBoarding =CacheHelper.GetData(key: ONBOARDING);
  token=CacheHelper.GetData(key: TOKEN);

  String initWidget;

  if(onBoarding!=null)
    {
      if(token!=null)
        {
          initWidget = HomeLayout.id;
        }
      else
        {
          print(token);
          initWidget = LoginScreen.id;
        }
    }
  else
    {
      initWidget = OnBoardingScreen.id;
    }
  runApp(MyApp(initWidget));
}

class MyApp extends StatelessWidget {

  final String initWidget;

  MyApp(this.initWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context )=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        initialRoute: initWidget,
        routes: {
          OnBoardingScreen.id : (context) =>OnBoardingScreen(),
          LoginScreen.id : (context)=>LoginScreen(),
          RegisterScreen.id :(context)=>RegisterScreen(),
          HomeLayout.id:(context)=>HomeLayout(),
          SearchScreen.id : (context)=>SearchScreen()
        },
        home: OnBoardingScreen()
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext ? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
