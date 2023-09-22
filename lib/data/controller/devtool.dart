import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DevtoolController extends GetxController {
  final int maxNumber = 50;
  final int removeStartIndex = 20;

  Rx<List<String>> httpInfoList = Rx<List<String>>([]);

  @override
  void onInit() {
    String token = "Bearer ${GetStorage().read('gft-user-token')}";

    httpInfoList.value.add(token);
    httpInfoList.refresh();
    super.onInit();
  }

  void addHttpInfo(String info) {
    if (httpInfoList.value.length > maxNumber) {
      httpInfoList.value.removeRange(removeStartIndex, maxNumber);
    }
    httpInfoList.value.insert(1, info);

    httpInfoList.refresh();
  }

  void clearHttpInfoList() {
    String token = "Bearer ${GetStorage().read('gft-user-token')}";

    httpInfoList.value = [token];
  }
}
