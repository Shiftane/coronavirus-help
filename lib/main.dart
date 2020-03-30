import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/app.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: GlobalKey(),
      title: 'Coronavirus Help',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: CompanyColors.blue,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          button: TextStyle(color : Colors.white),
          headline: TextStyle(color: CompanyColors.green)


          ),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          button: TextStyle(color : Colors.white),
          body2: TextStyle(fontStyle: FontStyle.italic)

          ),
        backgroundColor: CompanyColors.green,
        scaffoldBackgroundColor: Colors.white,
        buttonColor: CompanyColors.green,
        
        
      ),
      home: BasicApp(),
    );
  }
}

class CompanyColors{

  static final _blue = 0xFF70ACB1;
  static final _green = 0xFFC5F1E6;
  static final _grey = 0xFF59606D;

  CompanyColors._(); // this basically makes it so you can instantiate this class

  static MaterialColor blue = MaterialColor(
    _blue,
    <int, Color>{
      50: Color(_blue),
      100 : Color(_blue),
      200: Color(_blue),
      300: Color(_blue),
      400: Color(_blue),
      500: Color(_blue),
      600: Color(_blue),
      700: Color(_blue),
      800: Color(_blue),
      900: Color(_blue),
    }
  );
  static MaterialColor green = MaterialColor(
    _green,
    <int, Color>{
      50: Color(_green),
      100 : Color(_green),
      200: Color(_green),
      300: Color(_green),
      400: Color(_green),
      500: Color(_green),
      600: Color(_green),
      700: Color(_green),
      800: Color(_green),
      900: Color(_green),
    }
  );
  static MaterialColor grey = MaterialColor(
    _grey,
    <int, Color>{
      50: Color(_grey),
      100 : Color(_grey),
      200: Color(_grey),
      300: Color(_grey),
      400: Color(_grey),
      500: Color(_grey),
      600: Color(_grey),
      700: Color(_grey),
      800: Color(_grey),
      900: Color(_grey),
    }
  );
}