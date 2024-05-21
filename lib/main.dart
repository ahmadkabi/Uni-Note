import 'package:flutter/material.dart';
import 'package:uninote/cubit/note_cubit.dart';
import 'package:uninote/ui/page/home_page.dart';
import 'package:uninote/ui/page/note_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NoteCubit())],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomePage(title: 'Uni Note'),
          '/note-form': (context) => const NoteFormPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
