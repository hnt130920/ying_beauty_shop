import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:ying_beauty/model/cart_detail.dart';
import 'package:ying_beauty/model/request/update_cart.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cart_info_view_model.dart';
import 'package:ying_beauty/ui/cart/cart_screen.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:ying_beauty/ui/change_pass/change_pass_screen.dart';
import 'package:ying_beauty/ui/change_pass/change_pass_view_model.dart';
import 'package:ying_beauty/ui/login/login_screen.dart';
import 'package:ying_beauty/ui/personal/personal_form_screen.dart';
import 'package:ying_beauty/ui/receiver/receiver_screen.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
import 'package:ying_beauty/utils/app_variables.dart';
import 'package:ying_beauty/utils/prefs.dart';
import 'package:badges/badges.dart' as badges;

class PersonalSceen extends StatefulWidget {
  const PersonalSceen({super.key});

  @override
  State<PersonalSceen> createState() => _PersonalSceenState();
}

class _PersonalSceenState extends State<PersonalSceen> {
  final formKey = GlobalKey<FormBuilderState>();
  final changePassVM = ChangePassModel();
  final receiverVM = ReceiverViewModel();
  void changePassAction(var context, ChangePassModel model, int id) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
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
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mật khẩu nhập lại sai')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sai mật khẩu')));
      }
    }
  }

  void changData() async {
    final result = await ReceiverViewModel().getReceiver(AppVariable.reId);
    setState(() {
      AppVariable.receiver = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_2.jpg'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: const Icon(Icons.search)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, top: 6),
                                child: badges.Badge(
                                  badgeColor:
                                      const Color.fromARGB(255, 107, 148, 72),
                                  position: badges.BadgePosition.topEnd(
                                      top: 3, end: 2),
                                  badgeContent: Consumer<CartProvider>(
                                    builder: (context, value, child) {
                                      return Text(
                                        value.getCounter().toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      );
                                    },
                                  ),
                                  animationType:
                                      badges.BadgeAnimationType.scale,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CartScreen()));
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.grey,
                                        size: 28,
                                      )),
                                ),
                              )
                            ],
                          ),
                          const Text(
                            'Ying Beauty',
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 107, 148, 72),
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppVariable.userInfo!.username,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 201, 199, 199),
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.perm_contact_cal_outlined,
                            color: Color.fromARGB(255, 107, 148, 72),
                          ),
                          title: Text(AppVariable.userInfo!.fullName),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person_2,
                            color: Color.fromARGB(255, 107, 148, 72),
                          ),
                          title: Text(AppVariable.userInfo!.gender),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.mail_outline,
                            color: Color.fromARGB(255, 107, 148, 72),
                          ),
                          title: Text(AppVariable.userInfo!.email),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String refresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReceiverScreen()));

                      if (refresh == 'refresh') {
                        changData();
                      }
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.list_alt,
                          color: Color.fromARGB(255, 107, 148, 72),
                        ),
                        title: Text('Địa chỉ'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const ChangePasswordScreen())));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.key,
                          color: Color.fromARGB(255, 107, 148, 72),
                        ),
                        title: Text('Đổi mật khẩu'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      List<Cart> cartsDB = CartDBViewModel().carts;
                      final cartsInfo = CartViewModel();
                      if (cartsDB.isNotEmpty) {
                        List<CartDetail> cartList = [];
                        for (int i = 0; i < cartsDB.length; i++) {
                          final data = CartDetail(
                              proID: cartsDB[i].proId,
                              caDeQuantity: cartsDB[i].quantity);
                          cartList.add(data);
                        }
                        cartsInfo.save(UpdateCart(details: cartList));
                      }
                      receiverVM.clear();
                      AppVariable.reId = 0;
                      print('111');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoginScreen())),
                          (route) => false);
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.login_outlined,
                          color: Color.fromARGB(255, 107, 148, 72),
                        ),
                        title: Text('Đăng xuất'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 107, 148, 72),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PersonnalFormScreen())),
                      child: const Text("Chỉnh sửa thông tin")),
                ],
              ),
            )));
  }
}
