import 'package:flutter/material.dart';
import 'package:flutter_app/global_providers.dart';
import 'package:flutter_app/ui/add_note_screen/add_note_screen.dart';
import 'package:flutter_app/ui/homescreen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalProviders(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/home': (_) => const HomeScreen(),
            '/add': (_) => const AddNoteScreen(),
          },
          home: const HomeScreen()),
    );
  }
}
