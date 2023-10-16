import 'package:wins_app/models/login_response.dart';
import 'package:wins_app/models/serverInfo_response.dart';
import 'package:wins_app/resources/repository.dart';

class GlobalBloc {
  static const isSkipLogin = "N"; //hanya untuk testing ya
  static const prefApiUrl = "winsApiUrl";
  String isSwitched = "winsSwitchMode";
  String prefDatabase = "winsDatabase";

  String _url;
  String _switchMode = "Live";
  String _database = "NCF";

  String getPrefApiUrl() => prefApiUrl;
  String getSwitchMode() => isSwitched;
  String getDatabase() => prefDatabase;

  //String getUrl() => "http://116.254.101.55:8080/WINS_APP/"; //DEV
  //String getUrl() => "http://116.254.101.55:8080/NCF/"; //LIVE
  //String getUrl() => "http://116.254.101.55:8080/NCF_UAT/"; //UAT
  //String getUrl() => "http://116.254.101.55:8080/ADMART/"; //LIVE
  //String getUrl() => "http://116.254.101.55:8080/ADMART_UAT/"; //UAT

  String getUrl() => _url;
  String getSwitch() => _switchMode;
  String getDatabaseName() => _database;
  String setUrl(String url) => _url = url;
  String setSwitchMode(String switchMode) => _switchMode = switchMode;
  String setDatabaseName(String databaseName) => _database = databaseName;

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
