import 'package:flutter/material.dart';
import 'package:shlink_app/LoginView.dart';
import 'package:shlink_app/NavigationBarView.dart';
import 'globals.dart' as globals;
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
  ColorScheme.light();//.fromSwatch(primarySwatch: Colors.blue, backgroundColor: Colors.white);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          title: 'Shlink',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xfffafafa),
            ),
              colorScheme: lightColorScheme ?? _defaultLightColorScheme,
              useMaterial3: true
          ),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xff0d0d0d),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            colorScheme: darkColorScheme?.copyWith(background: Colors.black) ?? _defaultDarkColorScheme,
            useMaterial3: true,
          ),
          /*theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange
        )
      ),*/
          /*darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          background: Colors.black,
          surface: Color(0xff0d0d0d),
          secondaryContainer: Colors.grey[300]
        )
      ),*/
          themeMode: ThemeMode.system,
          home: InitialPage()
      );
    });
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {

    bool result = await globals.serverManager.checkLogin();
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NavigationBarView())
      );
    }
    else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("")
      ),
    );
  }
}
