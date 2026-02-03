class AlarmModel{
  String id;
  String time;
  String date;
  bool isActive;
  AlarmModel({required this.id, required this.time,required this.date, this.isActive=true});
}