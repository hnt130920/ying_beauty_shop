import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/base_result.dart';
import 'package:ying_beauty/model/receiver_info.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ReceiverViewModel extends Model {
  static final ReceiverViewModel _instance = ReceiverViewModel._internal();
  factory ReceiverViewModel() => _instance;
  ReceiverViewModel._internal() {
    updateList();
  }
  List<ReceiverInfo> receivers = [];
  Future<void> updateList() async {
    final results = await AppVariable.api.getReceiversInfo();
    receivers = results.data ?? [];
    notifyListeners();
  }

  Future<ReceiverInfo?> getReceiver(int id) async {
    BaseResult<ReceiverInfo> result = await AppVariable.api.getReceiverInfo(id);
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }

  void save(ReceiverInfo receiver) async {
    receiver.id == 0
        ? await AppVariable.api.addReceiverInfo(receiver)
        : await AppVariable.api.updateReceiverInfo(receiver.id, receiver);
    updateList();
  }

  void delete(ReceiverInfo receiver) async {
    await AppVariable.api.deleteReceiverInfo(receiver.id);
    updateList();
  }

  void clear() {
    receivers = [];
    notifyListeners();
  }
}
