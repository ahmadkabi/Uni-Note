import 'package:flutter/material.dart';
import 'package:uninote/ui/page/home_page.dart';
import 'package:uninote/ui/page/note_form_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(title: 'Uni Note'),
        '/note-form': (context) => const NoteFormPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}