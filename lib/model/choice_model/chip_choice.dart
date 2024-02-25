
class ChipChoice{
  ChipChoice({this.category, this.value, this.name});
  String? name;
  String? category;
  bool? value;

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'value': value,
  };

  ChipChoice.fromJson(Map<String, dynamic> json)
      : value = json['value'] as bool,
        name = json['name'],
        category = json['category'];
}