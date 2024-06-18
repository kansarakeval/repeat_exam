import 'package:get/get.dart';
import 'package:repeat_exam/screen/edit/model/edit_model.dart';
import 'package:repeat_exam/utils/db_helper.dart';

class EditController extends GetxController{

  RxList<EditModel> editList = <EditModel>[].obs;

  Future<void> getData() async {
    DBHelper helper = DBHelper();
    List<EditModel> data= await helper.readDB(EditModel());
    editList.value=data;
    }
}