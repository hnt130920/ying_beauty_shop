import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/receiver_info.dart';
import 'package:ying_beauty/ui/receiver/receiver.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ReceiverScreen extends StatefulWidget {
  const ReceiverScreen({super.key});

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen>
    with TickerProviderStateMixin {
  final receiverVM = ReceiverViewModel();

  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    receiverVM.updateList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: receiverVM,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 107, 148, 72),
              title: const Text('Địa chỉ'),
              actions: [
                IconButton(
                    onPressed: () {
                      _showEditDialog(context, receiverVM);
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(255, 226, 231, 222),
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/bg_login.jpg'),
                //     fit: BoxFit.cover,
                //     opacity: 0.5,
                //   ),
                // ),
                child: (receiverVM.receivers.isEmpty)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Text(
                              'Đang tải địa chỉ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 107, 148, 72),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(
                              value: controller.value,
                              semanticsLabel: 'Circular progress indicator',
                              color: const Color.fromARGB(255, 107, 148, 72),
                            ),
                          ])
                    : Column(
                        children: [
                          Expanded(
                            flex: 14,
                            child: _listReceivers(),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, 'refresh');
                              },
                              child: Container(
                                  width: double.infinity,
                                  color:
                                      const Color.fromARGB(255, 107, 148, 72),
                                  child: const Center(
                                    child: Text(
                                      'Cập nhật địa chỉ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ))));
  }

  int _groupvalue = AppVariable.reId;
  void getReceiver(var context, ReceiverViewModel model, int id) async {
    final receiver = await ReceiverViewModel().getReceiver(id);
    if (receiver != null) {
      AppVariable.receiver = receiver;
    }
  }

  Widget _listReceivers() => ScopedModelDescendant<ReceiverViewModel>(builder:
          (BuildContext context, Widget? child, ReceiverViewModel model) {
        return ListView.builder(
          itemCount: model.receivers.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Radio(
                  value: model.receivers[index].id,
                  groupValue: _groupvalue,
                  onChanged: (int? value) {
                    setState(() {
                      _groupvalue = value!;
                      AppVariable.reId = value;
                      getReceiver(context, model, value);
                    });
                  },
                ),
                Expanded(
                  child: Receiver(
                    receiver: model.receivers[index],
                    onClick: (receiver) =>
                        _showEditDialog(context, model, receiver: receiver),
                    onDelete: (receiver) => model.delete(receiver),
                  ),
                )
              ],
            );
            //
          },
        );
      });

  final _formKey = GlobalKey<FormBuilderState>();
  Future<void> _showEditDialog(var context, ReceiverViewModel model,
      {ReceiverInfo? receiver}) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: (receiver?.memId == null)
                ? const Text('Nhập địa chỉ mới')
                : const Text('Thay đổi địa chỉ'),
            content: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          initialValue: receiver?.name,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              labelText: 'Tên người nhận'),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FormBuilderTextField(
                          name: 'phone',
                          initialValue: receiver?.phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              labelText: 'Số điện thoại'),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FormBuilderTextField(
                          name: 'address',
                          initialValue: receiver?.address,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              labelText: 'Địa chỉ'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 248, 244, 244))),
                    child: const Text(
                      'Đóng',
                      style:
                          TextStyle(color: Color.fromARGB(255, 107, 148, 72)),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          final formValue = _formKey.currentState!.value;
                          final data = ReceiverInfo(
                              name: formValue['name'],
                              memId: AppVariable.userInfo!.id,
                              phone: formValue['phone'],
                              address: formValue['address']);
                          if (receiver != null) data.id = receiver.id;
                          model.save(data);
                          Navigator.pop(context);
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 107, 148, 72))),
                      child: const Text(
                        'Thêm',
                        style: TextStyle(
                            color: Color.fromARGB(255, 248, 244, 244)),
                      )),
                ],
              )
            ],
          );
        });
  }
}
