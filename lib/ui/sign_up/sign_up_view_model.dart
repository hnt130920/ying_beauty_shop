import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/request/sign_up.dart';
import 'package:ying_beauty/model/sign_up_info.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class SignUpViewModel extends Model {
  Future<SignUpInfo?> signUp(String username, String password, String name,
      String email, String gender) async {
    var result = await AppVariable.api.signUp(SignUp(
        username: username,
        password: password,
        name: name,
        email: email,
        gender: gender));
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }
}
