
import 'package:wego/utils/constans/prefs_keys.dart';
import 'item_element.dart';

class CalendarItemsModel{
  CalendarItemsModel({this.id, this.name, this.qty, this.elems, this.isDone = false});

  int? id;
  String? name;
  int? qty;
  bool? isDone;
  List<ItemElement>? elems;

  double itemsValueSummery(String? category){
    double total = 0;
    for( var item in elems!){
      if(category == workoutCategory){
        total += (qty! * item.value!);
      }else{
        total += item.value!;
      }

    }
    return total;
  }
}