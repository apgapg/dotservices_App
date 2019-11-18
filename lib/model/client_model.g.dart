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
          ?.toList(),
      json['address'] as String);
}

Map<String, dynamic> _$ClientItemToJson(ClientItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'description': instance.description,
      'area': instance.area,
      'address': instance.address,
      'areas': instance.areas,
      'categories': instance.categories
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['_id'] as String, json['category'] as String,
      json['image'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'image': instance.image
    };

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

Map<String, dynamic> _$AdvertisementToJson(Advertisement instance) =>
    <String, dynamic>{
      'image': instance.image,
      'visibility': instance.visibility,
      'client': instance.client
    };
