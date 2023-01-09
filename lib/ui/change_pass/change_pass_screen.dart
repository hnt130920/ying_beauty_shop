import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/login_info.dart';
import 'package:ying_beauty/ui/change_pass/change_pass_view_model.dart';
import 'package:ying_beauty/ui/login/login_screen.dart';
import 'package:ying_beauty/utils/app_variables.dart';
import 'package:ying_beauty/utils/prefs.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final changePassVM = ChangePassModel();

  void changePassAction(var context, ChangePassModel model, int id) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      var formValue = formKey.currentState!.value;
      final password = formValue['oldPass'].toString();
      final newPass = formValue['newPass'].toString();
      final againPass = formValue['againPass'].toString();
      final result = await model.changePass(id, password, newPass);
      if (result != null) {
        if (newPass == againPass) {
          Prefs.setPassword(newPass);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const LoginScreen())),
              (route) => false);
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mật khẩu nhập lại sai')));
        }
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sai mật khẩu')));
      }
    }
  }

  IconData icon = Icons.visibility_off;
  bool _hidePassword = true;
  void _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
      icon = _hidePassword ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: changePassVM,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 107, 148, 72),
              title: const Text('Đổi mật khẩu'),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FormBuilder(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderTextField(
                              obscureText: _hidePassword,
                              name: "oldPass",
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Mật khẩu hiện tại',
                                suffixIcon: IconButton(
                                  color: Colors.blueGrey,
                                  icon: Icon(icon),
                                  onPressed: _showPass,
                                ),
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FormBuilderTextField(
                              obscureText: true,
                              name: "newPass",
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Mật khẩu mới',
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FormBuilderTextField(
                              obscureText: true,
                              name: "againPass",
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nhập lại mật khẩu mới',
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8)
                              ]),
                            ),
                          ],
                        )),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 107, 148, 72),
                      ),
                      onPressed: () => changePassAction(
                          context, changePassVM, AppVariable.userInfo!.id),
                      child: const Text("Thay đổi mật khẩu")),
                ],
              ),
            )));
  }
}
