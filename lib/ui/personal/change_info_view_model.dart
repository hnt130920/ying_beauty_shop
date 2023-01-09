import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/change_info.dart';
import 'package:ying_beauty/model/login_info.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ChangeInfoViewModel extends Model {
  Future<LoginInfo?> changeInfo(
      String name, String gender, String email) async {
    var result = await AppVariable.api
        .changeInfo(ChangeInfo(name: name, email: email, gender: gender));
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }
}
