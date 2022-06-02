import 'package:checklist/models/list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemInfoPageController extends GetxController {
  TextEditingController itemName = TextEditingController();

  void toggleButton(CheckListModel checkListModel, bool? value, int index) {
    if (value == null) {
      return;
    }
    checkListModel.items[index].isChecked = value;
    update();
  }

  void removeData(int index, CheckListModel checkListModel) {
    checkListModel.items.removeAt(index);
    update();
  }
}
