import 'dart:convert';

import '../Helper/Database/BaseDatabase.dart';

class AppoinmentModel extends BaseModel<int> {
  @override
  int? id;
  int? userId;
  int? doctorId;
  DateTime? date;
  AppoinmentModel({
    this.id,
    this.userId,
    this.doctorId,
    this.date,
  });

  AppoinmentModel copyWith({
    int? id,
    int? userId,
    int? doctorId,
    DateTime? date,
  }) {
    return AppoinmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory AppoinmentModel.fromMap(Map<String, dynamic> map) {
    return AppoinmentModel(
      id: map['id']?.toInt(),
      userId: map['userId']?.toInt(),
      doctorId: map['doctorId']?.toInt(),
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
    );
  }

  factory AppoinmentModel.fromJson(String source) =>
      AppoinmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppoinmentModel(id: $id, userId: $userId, doctorId: $doctorId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppoinmentModel &&
        other.id == id &&
        other.userId == userId &&
        other.doctorId == doctorId &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ doctorId.hashCode ^ date.hashCode;
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return AppoinmentModel.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
