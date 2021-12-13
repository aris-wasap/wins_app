import 'package:wins_app/bloc_helpers/bloc_event_state.dart';
import 'package:wins_app/blocs/authentication/authentication_event.dart';
import 'package:wins_app/blocs/authentication/authentication_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/login_response.dart';
import 'package:wins_app/resources/repository.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          initialState: AuthenticationState.notAuthenticated(),
        );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    if (event is AuthenticationEventLogin) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      //await Future.delayed(const Duration(seconds: 2));
      try {
        if (GlobalBloc.isSkipLogin != "Y") {
          var _repository = Repository();
          LoginResponse loginResponse =
              await _repository.login(event.userName, event.pwd);
          if (loginResponse == null) {
            yield AuthenticationState.failure(errorMessage: 'Response null');
          } else {
            bool error = loginResponse.error;
            if (error) {
              yield AuthenticationState.failure(
                  errorMessage: 'Login fail : ${loginResponse.errorMessage}');
            } else {
              globalBloc.userName = event.userName;
              globalBloc.userId = loginResponse.data.userId;
              globalBloc.roleName = loginResponse.data.roleName;
              globalBloc.isAdmin = loginResponse.data.isAdmin;
              globalBloc.branchId = loginResponse.data.branchId;
              globalBloc.branchName = loginResponse.data.branchName;
              globalBloc.loginResponse = loginResponse;

              yield AuthenticationState.authenticated();
            }
          }
        } else {
          globalBloc.userName = "Admin";
          globalBloc.userId = 1;
          globalBloc.roleName = "Admin";
          globalBloc.isAdmin = "Y";
          globalBloc.branchId = 1;
          globalBloc.branchName = "IDU";

          //yield AuthenticationState.authenticated();
        }

        //yield AuthenticationState.authenticated();
      } catch (e) {
        yield AuthenticationState.failure(errorMessage: e.message);
      }
    } else if (event is AuthenticationEventLogout) {
      yield AuthenticationState.notAuthenticated();
    }
  }
}
