import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/ui/components/bottom_navigation_bar.dart';
import 'package:ying_beauty/ui/personal/change_info_view_model.dart';
import 'package:ying_beauty/ui/personal/personal_screen.dart';
import 'package:ying_beauty/utils/app_variables.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PersonnalFormScreen extends StatefulWidget {
  const PersonnalFormScreen({super.key});

  @override
  State<PersonnalFormScreen> createState() => _PersonnalFormScreenState();
}

class _PersonnalFormScreenState extends State<PersonnalFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final changeInfoVM = ChangeInfoViewModel();
  bool click = false;
  void changeInfoAction(var context, ChangeInfoViewModel model) async {
    setState(() {
      click = !click;
      // const PersonalSceen();
    });
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var formValue = formKey.currentState!.value;
      final name = formValue['name'].toString();
      final email = formValue['email'].toString();
      final gender = formValue['gender'].toString();
      final result = await model.changeInfo(name, gender, email);
      if (result != null) {
        AppVariable.userInfo = result;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomBar(
                      index: 2,
                    )),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Cập nhật thất bại')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: changeInfoVM,
        child: Scaffold(
            body: Container(
          padding: const EdgeInsets.all(12),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color.fromARGB(255, 70, 150, 91),
                    width: 1.0, // Underline thickness
                  ))),
                  child: const Text(
                    'Chỉnh sửa thông tin',
                    style: TextStyle(
                        fontSize: 28,
                        color: Color.fromARGB(255, 70, 150, 91),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: FormBuilder(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderTextField(
                            name: "name",
                            initialValue: AppVariable.userInfo!.fullName,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Tên '),
                            validator: FormBuilderValidators.required(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FormBuilderTextField(
                            name: "email",
                            initialValue: AppVariable.userInfo!.email,
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
                            initialValue: AppVariable.userInfo!.gender,
                            options: const [
                              FormBuilderFieldOption(value: 'Nam'),
                              FormBuilderFieldOption(value: 'Nữ'),
                              FormBuilderFieldOption(value: 'Khác'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                TextButton(
                    onPressed: click == true
                        ? null
                        : () => changeInfoAction(context, changeInfoVM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Cập nhật thông tin',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        (click == true)
                            ? LoadingAnimationWidget.waveDots(
                                color: Colors.green,
                                size: 24,
                              )
                            : const Icon(
                                Icons.edit,
                                size: 24,
                              ),
                      ],
                    ))
              ],
            ),
          ),
        )));
  }
}
