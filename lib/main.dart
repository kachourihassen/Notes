import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:digitrends/Screens/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/note_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return FlutterSplashScreen.fadeIn(
            animationDuration: const Duration(milliseconds: 2500),
            duration: const Duration(milliseconds: 4500),
            backgroundColor: Colors.white,
            onInit: () {
              debugPrint("On Init");
            },
            onEnd: () {
              debugPrint("On End");
            },
            childWidget: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/Digitrends.PNG"),
            ),
            onAnimationEnd: () => debugPrint("On Fade In End"),
            defaultNextScreen: MultiBlocProvider(
              providers: [
                BlocProvider<NoteBloc>(
                  create: (BuildContext context) =>
                      NoteBloc()..add(LoadNotes()),
                ),
              ],
              child: MyHomePage(),
            ),
          );
        }),
      ),
    );
  }
}
