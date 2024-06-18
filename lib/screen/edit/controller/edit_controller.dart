import 'package:get/get.dart';
import 'package:repeat_exam/screen/edit/model/edit_model.dart';
import 'package:repeat_exam/utils/db_helper.dart';
import 'package:repeat_exam/utils/shere_helper.dart';

class EditController extends GetxController {
  RxList<EditModel> editList = <EditModel>[].obs;
  RxBool isGrid = true.obs;
  RxBool islight = false.obs;
  RxString selectedCategory = ''.obs;


  Future<void> getData() async {
    DBHelper helper = DBHelper();
    List<EditModel> data = await helper.readDB(EditModel());
    editList.value = data;
  }


  void changeTheme() async {
    ShareHelper shr = ShareHelper();
    bool? istheme = await shr.getTheme();
    islight.value = istheme ?? false;
  }

  void updateCategory(int index) {
    switch (index) {
      case 0:
        selectedCategory.value = 'Low';
        break;
      case 1:
        selectedCategory.value = 'Medium';
        break;
      case 2:
        selectedCategory.value = 'High';
        break;
      case 3:
        selectedCategory.value = 'Urgent';
        break;
    }
  }

  Future<void> updateData(EditModel editModel) async {
    DBHelper helper = DBHelper();
    await helper.updateDB(editModel);
    getData();
  }
}
