import 'dart:convert';

class CheckListItemModel {
  bool isChecked;
  String text;

  CheckListItemModel({
    this.isChecked = false,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      "isChecked": isChecked,
      "text": text,
    };
  }

  factory CheckListItemModel.fromMap(Map<String, dynamic> map) {
    return CheckListItemModel(
      text: map["text"],
      isChecked: map["isChecked"],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory CheckListItemModel.fromJson(String json) {
    return CheckListItemModel.fromMap(jsonDecode(json));
  }
}
