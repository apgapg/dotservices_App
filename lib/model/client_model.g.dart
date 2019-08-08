// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientItem _$ClientItemFromJson(Map<String, dynamic> json) {
  return ClientItem(
      json['id'] as String,
      json['name'] as String,
      json['number'] as String,
      (json['categories'] as List)
          ?.map((e) =>
              e == null ? null : Category.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['description'] as String,
      json['area'] as String,
      (json['areas'] as List)
          ?.map((e) =>
              e == null ? null : Area.fromJson(e as Map<String, dynamic>))
          ?.toList());
}


Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['category'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'category': instance.category};

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(json['area'] as String);
}

Map<String, dynamic> _$AreaToJson(Area instance) =>
    <String, dynamic>{'area': instance.area};

Advertisement _$AdvertisementFromJson(Map<String, dynamic> json) {
  return Advertisement(
      json['image'] as String,
      json['visibility'] as bool ?? false,
      json['client'] == null
          ? null
          : ClientItem.fromJson(json['client'] as Map<String, dynamic>));
}
