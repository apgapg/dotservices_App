// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
      androidId: json['androidId'] as String,
      longitude: (json['longitude'] as num)?.toDouble(),
      latitude: (json['latitude'] as num)?.toDouble(),
      accuracy: json['accuracy'] as int,
      source: json['source'] as String ?? 'location 1.3.4',
      captureTime: json['captureTime'] as int ?? 5,
      time: (json['time'] as num)?.toDouble(),
      capturedAddress: json['capturedAddress'] as String);
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'androidId': instance.androidId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'accuracy': instance.accuracy,
      'source': instance.source,
      'captureTime': instance.captureTime,
      'time': instance.time,
      'capturedAddress': instance.capturedAddress
    };
