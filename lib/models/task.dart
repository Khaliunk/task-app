import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String subtitle;

  @HiveField(3)
  DateTime selectedTime;

  @HiveField(4)
  DateTime selectedDate;

  @HiveField(5)
  bool isCompleted;

  Task({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.id,
    required this.selectedTime,
    required this.selectedDate,
  });

  @override
  String toString() {
    return 'Task(title: $title, subtitle: $subtitle, isCompleted: $isCompleted)';
  }

  factory Task.create({
    String? id,
    required String? title,
    required String? subtitle,
    required DateTime? selectedDate,
    required DateTime? selectedTime,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? "${DateTime.now().millisecondsSinceEpoch}",
      title: title ?? "",
      subtitle: subtitle ?? "",
      selectedDate: selectedDate ?? DateTime.now(),
      selectedTime: selectedTime ?? DateTime.now(),
      isCompleted: isCompleted ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "isCompleted": isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"] ?? "${DateTime.now().millisecondsSinceEpoch}",
      title: map["title"] ?? "",
      subtitle: map["subtitle"] ?? "",
      selectedDate:
          map["selectedDate"] is DateTime
              ? map["selectedDate"]
              : DateTime.tryParse(map["selectedDate"]?.toString() ?? "") ??
                  DateTime.now(),
      selectedTime:
          map["selectedTime"] is DateTime
              ? map["selectedTime"]
              : DateTime.tryParse(map["selectedTime"]?.toString() ?? "") ??
                  DateTime.now(),
      isCompleted:
          map["isCompleted"] is bool
              ? map["isCompleted"]
              : (map["isCompleted"]?.toString() == "true"),
    );
  }

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Task(
      id: snapshot["id"] ?? "${DateTime.now().millisecondsSinceEpoch}",
      title: snapshot["title"] ?? "",
      subtitle: snapshot["subtitle"] ?? "",
      selectedDate:
          snapshot["selectedDate"] is DateTime
              ? snapshot["selectedDate"]
              : DateTime.tryParse(snapshot["selectedDate"]?.toString() ?? "") ??
                  DateTime.now(),
      selectedTime:
          snapshot["selectedTime"] is DateTime
              ? snapshot["selectedTime"]
              : DateTime.tryParse(snapshot["selectedTime"]?.toString() ?? "") ??
                  DateTime.now(),
      isCompleted:
          snapshot["isCompleted"] is bool
              ? snapshot["isCompleted"]
              : (snapshot["isCompleted"]?.toString() == "true"),
    );
  }
}
