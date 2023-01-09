import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/ui/login/login_screen.dart';
import 'package:ying_beauty/ui/sign_up/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final sinUpVM = SignUpViewModel();
  void signUpAction(var context, SignUpViewModel model) async {
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
      final username = formValue['username'].toString();
      final password = formValue['password'].toString();
      final name = formValue['name'].toString();
      final email = formValue['email'].toString();
      final gender = formValue['gender'].toString();
      final result =
          await model.signUp(username, password, name, email, gender);
      if (result != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tên đăng nhập đã tồn tại')));
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
      model: sinUpVM,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_login.jpg'),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Tạo Tài Khoản',
                          style: TextStyle(
                              color: Color.fromARGB(255, 70, 150, 91),
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      FormBuilderTextField(
                        name: "username",
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Tên đăng nhập'),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                          obscureText: _hidePassword,
                          name: "password",
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Mật khẩu',
                            suffixIcon: IconButton(
                              color: Colors.blueGrey,
                              icon: Icon(icon),
                              onPressed: _showPass,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(8)
                          ])),
                      FormBuilderTextField(
                        name: "name",
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(), labelText: 'Tên '),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormBuilderTextField(
                        name: "email",
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Địa chỉ email'),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Giới tính'),
                      FormBuilderRadioGroup(
                        name: 'gender',
                        options: const [
                          FormBuilderFieldOption(value: 'Nam'),
                          FormBuilderFieldOption(value: 'Nữ'),
                          FormBuilderFieldOption(value: 'Khác'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => signUpAction(context, sinUpVM),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 107, 148, 72),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                  ),
                  child: const Text('Đăng Ký'),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
