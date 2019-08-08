import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  String androidId;
  double longitude;
  double latitude;
  int accuracy;
  @JsonKey(defaultValue: "location 1.3.4")
  String source = "location 1.3.4";
  @JsonKey(defaultValue: 5)
  int captureTime = 5;
  double time;
  String capturedAddress;

  LocationModel({
    this.androidId,
    this.longitude,
    this.latitude,
    this.accuracy,
    this.source,
    this.captureTime,
    this.time,
    this.capturedAddress,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

int _accuracyToInt(double accuracy) => accuracy.round();
