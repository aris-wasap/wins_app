import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends BlocEvent {
  AuthenticationEvent({
    this.userName,
    this.pwd,
  });

  final String userName;
  final String pwd;
}

class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({
    @required String userName,
    @required String pwd,
  }) : super(
          userName: userName,
          pwd: pwd,
        );
}

class AuthenticationEventLogout extends AuthenticationEvent {}
