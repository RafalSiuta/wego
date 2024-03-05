import 'calendar_items_model.dart';

class UserCalendarModel {

  UserCalendarModel({this.id, this.title,this.subtitle, this.category, this.imagePath, this.progressValue, this.date, this.items});
  int? id;
  String? title;
  String? subtitle;
  String? category;
  String? imagePath;
  double? progressValue;
  DateTime? date;
  List<CalendarItemsModel>? items;




}