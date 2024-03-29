import 'package:wego/model/chart_model/chart_model.dart';


final List<ChartModel> DUMMY_CHART_DATA = [
  ChartModel(1, DateTime.now(), 25, 'data'),
  ChartModel(1, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 22, 'data'),
  ChartModel(1, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 29, 'data'),
  ChartModel(1, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 29, 'data'),
];