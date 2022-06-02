import 'dart:convert';
import 'package:checklist/models/card_model.dart';

class CheckListModel {
  String name;
  List<CheckListItemModel> items = [];
  bool isChecked;

  CheckListModel({
    required this.name,
    this.isChecked = true,
    List<CheckListItemModel>? items,
  }) : items = items ?? [];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "isChecked": isChecked,
      "items": items.map((e) => e.toMap()).toList()
    };
  }

  factory CheckListModel.fromMap(Map<String, dynamic> map) {
    List list = map["items"];
    List<CheckListItemModel> mapList =
        list.map((e) => CheckListItemModel.fromMap(e)).toList();
    return CheckListModel(
      name: map["name"],
      isChecked: map["isChecked"],
      items: mapList,
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory CheckListModel.fromJson(String json) {
    return CheckListModel.fromMap(jsonDecode(json));
  }
}
