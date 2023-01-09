import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cart_view_model.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:ying_beauty/ui/components/banner_view_model.dart';
import 'package:ying_beauty/ui/components/bottom_navigation_bar.dart';
import 'package:ying_beauty/ui/login/login_view_model.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
import 'package:ying_beauty/ui/sign_up/sign_up_screen.dart';
import 'package:ying_beauty/utils/app_variables.dart';
import 'package:ying_beauty/utils/prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final loginViewModel = LoginViewModel();
  bool click = false;
  void loginAction(var context, LoginViewModel model) async {
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
      final username = formValue['username'].toString().trim();
      final password = formValue['password'].toString().trim();
      final result = await model.login(username, password);
      if (result != null) {
        CartDBViewModel cartsDB = CartDBViewModel();
        AppVariable.userInfo = result;
        Prefs.setUsername(username);
        Prefs.setPassword(password);
        CartProvider().setInitialCounter();
        cartsDB.clearCart();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => const BottomBar())),
            (route) => false);
        ReceiverViewModel receiverVM = ReceiverViewModel();
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tên đăng nhập hoặc mật khẩu sai')));
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
    BannerViewModel bannerVM = BannerViewModel();
    return ScopedModel(
      model: loginViewModel,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(32),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_login.jpg'),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 12, 150, 67),
                        width: 2),
                    // color: ,
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormBuilder(
                        key: formKey,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'username',
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  labelText: 'Tên đăng nhập'),
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                // FormBuilderValidators.minLength(8)
                              ]),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FormBuilderTextField(
                              obscureText: _hidePassword,
                              name: 'password',
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0))),
                                labelText: 'Mật khẩu',
                                suffixIcon: IconButton(
                                  color: Colors.blueGrey,
                                  icon: Icon(icon),
                                  onPressed: _showPass,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.required(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                        onPressed: () => loginAction(context, loginViewModel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 107, 148, 72),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 46),
                        ),
                        child: const Text('Đăng nhập'),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignUpScreen())),
                              (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 107, 148, 72),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 54),
                        ),
                        child: const Text('Đăng ký'),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
