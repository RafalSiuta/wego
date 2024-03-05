

import 'item_element.dart';

class CalendarItemsModel{
  CalendarItemsModel({this.id, this.name, this.qty, this.items, this.isDone = false});

  int? id;
  String? name;
  int? qty;
  bool? isDone;
  List<ItemElement>? items;
}