
import 'package:wego/utils/constans/prefs_keys.dart';
import 'item_element.dart';

class CalendarItemsModel{
  CalendarItemsModel({this.id, this.name, this.qty, this.elems, this.isDone = false});

  int? id;
  String? name;
  int? qty;
  bool? isDone;
  List<ItemElement>? elems;

  // double itemsValueSummery(String? category){
  //   double total = 0;
  //   if(elems != null){
  //     for( var item in elems){
  //       if(category == workoutCategory){
  //         total += (qty! * item.value);
  //       }else{
  //         total += item.value;
  //       }
  //
  //     }
  //   }
  //
  //   return total;
  // }
  double itemsValueSummery(String? category) {
    double total = 0;
    elems?.forEach((item) {
      double itemValue = item.value ?? 0;
      if (category != null && category == workoutCategory) {
        int effectiveQty = qty ?? 0;
        total += (effectiveQty * itemValue);
      } else {
        total += itemValue;
      }
    });
    return total;
  }

}