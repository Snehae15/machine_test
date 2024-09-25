import 'package:get/get.dart';
import 'package:practice/model/jewellery_model.dart';
import 'package:practice/services/api_service.dart';

class JewelleryListViewModel extends GetxController {
  final ApiService apiService;

  final images = RxList<JewelleryModel>([]);
  final isLoading = RxBool(false);
  final errorMessage = RxString('');

  JewelleryListViewModel(this.apiService);

  Future<void> fetchImages() async {
    try {
      isLoading.value = true;
      images.value = await apiService.fetchImages(); 
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }
}
