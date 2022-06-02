import 'package:checklist/controllers/home_page_controller.dart';
import 'package:checklist/models/list_model.dart';
import 'package:checklist/views/items_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePageScreen extends StatelessWidget {
  HomePageController controller = Get.put(HomePageController());
  Widget appBarTitle = const Text(
    "Search checklist name",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        controller.storeListData();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Add Items"),
                  content: TextField(
                    autofocus: true,
                    decoration:
                        const InputDecoration(hintText: "Enter list item name"),
                    controller: controller.itemName,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                        controller.itemName.text = "";
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.addData();
                        Get.back();
                        controller.itemName.text = "";
                      },
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: GetBuilder<HomePageController>(
                builder: (controller) => AppBar(
                  centerTitle: true,
                  title: appBarTitle,
                  actions: <Widget>[
                    IconButton(
                      icon: icon,
                      onPressed: () {
                        if (icon.icon == Icons.search) {
                          icon = const Icon(
                            Icons.close,
                            color: Colors.white,
                          );
                          appBarTitle = TextField(
                            autofocus: true,
                            controller: controller.searchItemName,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                                hintText: "Search...",
                                hintStyle: TextStyle(color: Colors.white)),
                            onChanged: controller.searchOperation,
                          );
                          controller.handleSearchStart();
                        } else {
                          icon = const Icon(
                            Icons.search,
                            color: Colors.white,
                          );
                          appBarTitle = const Text(
                            "Search checklist name",
                            style: TextStyle(color: Colors.white),
                          );
                          controller.handleSearchEnd();
                        }
                      },
                    ),
                  ],
                ),
              )),
          body: GetBuilder<HomePageController>(
            builder: (controller) {
              return controller.searchItemName.text.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.searchresult.length,
                      itemBuilder: (BuildContext context, int index) {
                        CheckListModel listData =
                            controller.searchresult[index];
                        return InkWell(
                          onTap: () {
                            Get.to(ItemInfoPage(listData));
                            // print(controller.searchresult[index]);
                          },
                          child: IntrinsicHeight(
                            child: Card(
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.blue),
                                        checkColor: MaterialStateProperty.all(
                                            Colors.white),
                                      ),
                                    ),
                                    child: Checkbox(
                                        shape: const CircleBorder(),
                                        value: controller
                                            .searchresult[index].isChecked,
                                        onChanged: null),
                                  ),
                                  Text(controller.searchresult[index].name),
                                  const Spacer(),
                                  Text(
                                    controller.searchresult[index].items.length
                                        .toString(),
                                  ),
                                  const VerticalDivider(
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.removeData(index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.checkLists.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(ItemInfoPage(
                              controller.checkLists[index],
                            ))?.then((value) {
                              controller.update();
                              controller.checkAllTrue();
                            });
                          },
                          child: IntrinsicHeight(
                            child: Card(
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.blue),
                                        checkColor: MaterialStateProperty.all(
                                            Colors.white),
                                      ),
                                    ),
                                    child: Checkbox(
                                        shape: const CircleBorder(),
                                        value: controller
                                            .checkLists[index].isChecked,
                                        onChanged: null),
                                  ),
                                  Text(controller.checkLists[index].name),
                                  const Spacer(),
                                  Text(
                                    controller.checkLists[index].items.length
                                        .toString(),
                                  ),
                                  const VerticalDivider(
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.removeData(index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
