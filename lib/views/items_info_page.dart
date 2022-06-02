import 'package:checklist/controllers/item_info_page_controller.dart';
import 'package:checklist/models/card_model.dart';
import 'package:checklist/models/list_model.dart';
import 'package:checklist/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemInfoPage extends StatelessWidget {
  ItemInfoPageController controller = Get.put(ItemInfoPageController());
  // CardModel cardModel;
  CheckListModel checkList;
  ItemInfoPage(this.checkList);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: Text("Item Name"),
                content: TextField(
                  autofocus: true,
                  controller: controller.itemName,
                  decoration: InputDecoration(hintText: "Enter Item Name"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                      controller.itemName.text = "";
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      checkList.items.add(CheckListItemModel(
                          text: controller.itemName.text.toCapitalized()));
                      // Preferences.setItemName(controller.itemName.text);
                      Get.back();
                      controller.itemName.text = "";

                      controller.update();
                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(checkList.name),
        ),
        body: GetBuilder<ItemInfoPageController>(
          builder: (controller) {
            return ListView.builder(
              itemCount: checkList.items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkList.items[index].isChecked,
                        onChanged: (bool? value) {
                          controller.toggleButton(checkList, value, index);
                        },
                      ),
                      Text(checkList.items[index].text),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          controller.removeData(index, checkList);
                        },
                        icon: Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
