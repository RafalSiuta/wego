class ChartModel {
  DateTime? dateTime;
  double? value;
  String? name;
  int? id;


  ChartModel(this.id, this.dateTime, this.value, this.name);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['date_time'] = dateTime;
    map['value'] = value;
    map['name'] = name;

    return map;
  }

  ChartModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    dateTime = map['date_time'] as DateTime;
    value = map['value'] as double;
    name = map['name'] as String;
  }
}