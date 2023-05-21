import '../Helper/Database/BaseDatabase.dart';

class ReportModel extends BaseModel<int> {
  @override
  int? id;
  int? userId;
  DateTime? reportDateTime;
  String? cancerStage;
  String? imagePath;
  ReportModel({
    this.id,
    this.userId,
    this.reportDateTime,
    this.cancerStage,
    this.imagePath,
  });

  ReportModel copyWith({
    int? id,
    int? userId,
    DateTime? reportDateTime,
    String? cancerStage,
    String? imagePath,
  }) {
    return ReportModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reportDateTime: reportDateTime ?? this.reportDateTime,
      cancerStage: cancerStage ?? this.cancerStage,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'reportDateTime': reportDateTime?.toIso8601String(),
      'cancerStage': cancerStage,
      'imagePath': imagePath,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id']?.toInt(),
      userId: map['userId']?.toInt(),
      reportDateTime: map['reportDateTime'] != null
          ? DateTime.parse(map['reportDateTime'])
          : null,
      cancerStage: map['cancerStage'],
      imagePath: map['imagePath'],
    );
  }

  @override
  String toString() {
    return 'ReportModel(id: $id, userId: $userId, reportDateTime: $reportDateTime, cancerStage: $cancerStage, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportModel &&
        other.id == id &&
        other.userId == userId &&
        other.reportDateTime == reportDateTime &&
        other.cancerStage == cancerStage &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        reportDateTime.hashCode ^
        cancerStage.hashCode ^
        imagePath.hashCode;
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return ReportModel.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
