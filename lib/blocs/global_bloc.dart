import 'package:wins_app/models/login_response.dart';
import 'package:wins_app/models/serverInfo_response.dart';
import 'package:wins_app/resources/repository.dart';

class GlobalBloc {
  static const isSkipLogin = "N"; //hanya untuk testing ya
  static const prefApiUrl = "admartApiUrl";

  String _url;

  String getPrefApiUrl() => prefApiUrl;

  //String getUrl() => "http://192.168.43.73/wins_app/"; //wifi huawai
  //String getUrl() => "http://192.168.113.125/admart_APP/"; //wifi bb
  // String getUrl() => "http://192.168.1.106/admart_APP/"; //wifi kosan
  //String getUrl() => "http://192.168.17.37/admart_APP/"; //kantor
  //String getUrl() => "http://192.168.1.12/admart_APP/"; //kantor

  String getUrl() => _url;
  String setUrl(String url) => _url = url;

  int userId;
  String userName;
  String roleName;
  String isAdmin;
  int branchId;
  String branchName;

  LoginResponse loginResponse = LoginResponse();

  Future<DateTime> getServerDate() async {
    try {
      var _repository = Repository();
      ServerInfoResponse response = await _repository.getServerInfo();
      if (response != null) {
        if (response.data != null) {
          return response.data.serverDate;
        }
      } else {}
    } catch (e) {}
  }
}

GlobalBloc globalBloc = GlobalBloc();
