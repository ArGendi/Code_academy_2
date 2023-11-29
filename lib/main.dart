import 'package:code_academy_2/bloc/users_cubit.dart';
import 'package:code_academy_2/constants.dart';
import 'package:code_academy_2/routes.dart';
import 'package:code_academy_2/screens/home_screen.dart';
import 'package:code_academy_2/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('users');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UsersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MyRoutes.generateRoute,
      ),
    );
  }
}