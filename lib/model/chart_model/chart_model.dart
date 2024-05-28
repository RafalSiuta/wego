class ChartModel {
  DateTime? dateTime;
  double? value;
  String? unit;
  String? name;
  int? id;


  ChartModel(this.id, this.dateTime, this.value, this.unit,{this.name});


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['date_time'] = dateTime;
    map['value'] = value;
    map['unit'] = unit;
    map['name'] = name;

    return map;
  }

  ChartModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    dateTime = map['date_time'] as DateTime;
    value = map['value'] as double;
    unit = map['unit'] as String;
    name = map['name'] as String;
  }
}