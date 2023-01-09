import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/login_info.dart';
import 'package:ying_beauty/model/request/login_request.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class LoginViewModel extends Model {
  Future<LoginInfo?> login(String username, String password) async {
    var result = await AppVariable.api
        .login(LoginRequest(username: username, password: password));
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }
}
