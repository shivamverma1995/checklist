import 'dart:convert';
import 'package:checklist/models/list_model.dart';
import 'package:checklist/string_extension.dart';
import 'package:checklist/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  // ItemInfoPageController infoPageController = Get.put(ItemInfoPageController());
  TextEditingController itemName = TextEditingController();
  TextEditingController searchItemName = TextEditingController();
  List<CheckListModel> checkLists = [];
  bool isSearching = false;
  List<CheckListModel> searchresult = [];

  void handleSearchStart() {
    isSearching = true;
    update();
  }

  void handleSearchEnd() {
    isSearching = false;
    searchItemName.clear();
    update();
  }

  void addData() {
    if (itemName.text.isEmpty) {
      return;
    }
    checkLists.add(CheckListModel(name: itemName.text.toCapitalized()));

    // boolList.add(false);
    update();
  }

  void removeData(int index) {
    checkLists.removeAt(index);
    String checkListJson = jsonEncode(checkLists);
    Preferences.setItemName(checkListJson);
    print(checkLists.length);
    update();
  }

  void checkAllTrue() {
    for (int i = 0; i < checkLists.length; i++) {
      print(checkLists[i].items.length);
      checkLists[i].isChecked = checkLists[i]
          .items
          .map((e) => e.isChecked)
          .reduce((value, element) => value && element);
      print(checkLists[i].isChecked);
      update();
    }
  }

  void storeListData() {
    String checkListJson = jsonEncode(checkLists);
    Preferences.setItemName(checkListJson);
    update();
  }

  getListData() async {
    List checkList = [];
    if (Preferences.getItemName().isEmpty) {
      return;
    }
    checkList = jsonDecode(Preferences.getItemName());
    checkLists = checkList.map((e) => CheckListModel.fromJson(e)).toList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getListData();
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    // List<String> checkListJson = checkLists.map((e) => e.name).toList();
    // print(checkListJson);
    if (isSearching == true) {
      for (int i = 0; i < checkLists.length; i++) {
        CheckListModel data = checkLists[i];
        if (checkLists[i]
            .name
            .toLowerCase()
            .startsWith(searchText.toLowerCase())) {
          searchresult.add(data);
          update();
        }
        update();
      }
      update();
    }
  }
}
