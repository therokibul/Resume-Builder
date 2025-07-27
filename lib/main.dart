import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resume_builder/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:resume_builder/features/resume/presentation/pages/resume_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResumeBloc(),
      child: MaterialApp(
        title: 'Flutter Resume Builder',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.teal,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        home: const ResumeFormScreen(),
      ),
    );
  }
}
