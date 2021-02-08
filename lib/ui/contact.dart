import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/bloc/auth_bloc.dart';

// class Contact extends StatelessWidget {
//   const Contact({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text("Eres un Alumno"),
//       ),
//     );
//   }
// }
class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  AuthBloc vueltaBloc;

  @override
  void initState() {
    vueltaBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            return Navigator.pushNamed(context, '/contact');
          } else if (state is AdminLoginSuccessState) {
            return Navigator.pushNamed(context, '/addcontact');
          } else if (state is ControlPageState) {
            return Navigator.pushNamed(context, '/');
          }
        },
        child: Container(
          child: Center(
              child: RaisedButton(
                  child: Text("Cierra Sesion de Usuario"),
                  onPressed: () {
                    vueltaBloc.add(EliminarToken());
                  })),
        ),
      ),
    );
  }
}
