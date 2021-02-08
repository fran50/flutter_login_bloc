import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/bloc/auth_bloc.dart';
import 'package:flutter_login_bloc/repository/auth_repo.dart';
import 'package:flutter_login_bloc/ui/addcontact.dart';
import 'package:flutter_login_bloc/ui/contact.dart';
import 'package:flutter_login_bloc/ui/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(AuthInitial(), AuthRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/contact': (context) => Contact(),
          '/addcontact': (context) => AddContact(),
        },
      ),
    );
  }
}
