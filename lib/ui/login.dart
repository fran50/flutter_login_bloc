import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/bloc/auth_bloc.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(ComprobarPaginas());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
      child: Icon(Icons.account_circle_rounded, size: 150, color: Colors.blue),
    );

    final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoginErrorState) {
        return Text(state.message);
      } else if (state is LoginLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Container();
      }
    });

    final username = TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.white),
          filled: true,
          fillColor: Colors.blue,
          hintStyle: TextStyle(color: Colors.white60),
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
    final pass = TextField(
      controller: password,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          filled: true,
          fillColor: Colors.blue,
          hintStyle: TextStyle(color: Colors.white60),
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          onPressed: () {
            authBloc.add(
                LoginButtonPress(email: email.text, password: password.text));
          },
          padding: EdgeInsets.all(15),
          color: Colors.lightBlue,
          child: Text('Login',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ));

    return Scaffold(
        backgroundColor: Colors.white10,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserLoginSuccessState) {
              return Navigator.pushNamed(context, '/contact');
            } else if (state is AdminLoginSuccessState) {
              return Navigator.pushNamed(context, '/addcontact');
            }
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 20.0),
                msg,
                SizedBox(height: 48.0),
                username,
                SizedBox(height: 20.0),
                pass,
                SizedBox(height: 24.0),
                loginButton
              ],
            ),
          ),
        ));
  }
}
