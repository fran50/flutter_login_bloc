import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login_bloc/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    var pref = await SharedPreferences.getInstance();

    if (event is StartEvent) {
      yield LoginInitialState();
    } else if (event is LoginButtonPress) {
      yield AuthInitial();
      var data = await repo.login(event.email, event.password);

      if (data['usuarioLogin']['role'] == "user") {
        pref.setString('token', data['token']);
        pref.setString('role', data['usuarioLogin']['role']);
        yield UserLoginSuccessState();
      } else if (data['usuarioLogin']['role'] == "admin") {
        pref.setString('token', data['token']);
        pref.setString('role', data['usuarioLogin']['role']);
        yield AdminLoginSuccessState();
      } else {
        yield LoginErrorState(message: data['msg'][0]);
      }
    } else if (event is ComprobarPaginas) {
      if (pref.getString('token') == null) {
        yield LoginInitialState();
      } else {
        if (pref.getString('role') == 'user') {
          yield UserLoginSuccessState();
        } else if (pref.getString('role') == 'admin') {
          yield AdminLoginSuccessState();
        }
      }
    } else if (event is EliminarToken) {
      pref.clear();
      yield ControlPageState();
    }
  }
}
