import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/change_password_info.dart';
import 'package:ying_beauty/model/request/change_password.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ChangePassModel extends Model {
  Future<ChangePasswordInfo?> changePass(
      int id, String password, String newPass) async {
    var result = await AppVariable.api
        .changePass(id, ChangePassword(password: password, newPass: newPass));
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }
}
