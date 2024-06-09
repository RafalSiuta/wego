import 'calendar_items_model.dart';

class UserCalendarModel {

  UserCalendarModel({this.id, this.title,this.subtitle, this.category, this.imagePath,  this.date, this.items});
  int? id;
  String? title;
  String? subtitle;
  String? category;
  String? imagePath;
  //double? progressValue;
  DateTime? date;
  List<CalendarItemsModel>? items;

  double totalValSummary(){
    double total = 0;
    items?.forEach((item) {
      total += item.itemsValueSummery(category);
    });
    // if(items != null){
    //   for(var item in items!){
    //     total += item.itemsValueSummery(category);
    //   }
    // }

    return total;
  }

  double percentProgress(){
    double progress = 0;
    double scaledProgress = 0;
    double? totalValue = totalValSummary();
    items?.forEach((item) {
      if(item.isDone! == true){
        progress += item.itemsValueSummery(category);
      }
    });

    scaledProgress = progress / totalValue;
    // if(items != []){
    //   for(var item in items!){
    //     if(item.isDone! == true){
    //       progress += item.itemsValueSummery(category);
    //     }
    //   }
    //
    // }



    return scaledProgress;
  }




}