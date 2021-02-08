// import 'package:flutter/material.dart';

// class AddContact extends StatelessWidget {
//   const AddContact({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text("Eres un Administador"),
//       ),
//     );
//   }
// }
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
class AddContact extends StatefulWidget {
  AddContact({Key key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  AuthBloc vueltaBloc;

  @override
  void initState() {
    vueltaBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
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
                  child: Text("Cierra Sesion de Administrador"),
                  onPressed: () {
                    vueltaBloc.add(EliminarToken());
                  })),
        ),
      ),
    );
  }
}
