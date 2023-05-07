import 'package:cancerrapp/Helper/Database/BaseDatabase.dart';

class DoctorModel extends BaseModel<int> {
  @override
  int? id;
  String? name;
  String? mobileNumber;
  String? city;
  String? hospitalName;
  String? specilist;
  String? doctorTiming;
  String? doctorDay;
  String? imagePath;
  DoctorModel({
    this.id,
    this.name,
    this.mobileNumber,
    this.city,
    this.hospitalName,
    this.specilist,
    this.doctorTiming,
    this.doctorDay,
    this.imagePath,
  });

  DoctorModel copyWith({
    int? id,
    String? name,
    String? mobileNumber,
    String? city,
    String? hospitalName,
    String? specilist,
    String? doctorTiming,
    String? doctorDay,
    String? imagePath,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      city: city ?? this.city,
      hospitalName: hospitalName ?? this.hospitalName,
      specilist: specilist ?? this.specilist,
      doctorTiming: doctorTiming ?? this.doctorTiming,
      doctorDay: doctorDay ?? this.doctorDay,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'city': city,
      'hospitalName': hospitalName,
      'specilist': specilist,
      'doctorTiming': doctorTiming,
      'doctorDay': doctorDay,
      'imagePath': imagePath,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id']?.toInt(),
      name: map['name'],
      mobileNumber: map['mobileNumber'],
      city: map['city'],
      hospitalName: map['hospitalName'],
      specilist: map['specilist'],
      doctorTiming: map['doctorTiming'],
      doctorDay: map['doctorDay'],
      imagePath: map['imagePath'],
    );
  }

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, mobileNumber: $mobileNumber, city: $city, hospitalName: $hospitalName, specilist: $specilist, doctorTiming: $doctorTiming, doctorDay: $doctorDay, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoctorModel &&
        other.id == id &&
        other.name == name &&
        other.mobileNumber == mobileNumber &&
        other.city == city &&
        other.hospitalName == hospitalName &&
        other.specilist == specilist &&
        other.doctorTiming == doctorTiming &&
        other.doctorDay == doctorDay &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mobileNumber.hashCode ^
        city.hashCode ^
        hospitalName.hashCode ^
        specilist.hashCode ^
        doctorTiming.hashCode ^
        doctorDay.hashCode ^
        imagePath.hashCode;
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return DoctorModel.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
