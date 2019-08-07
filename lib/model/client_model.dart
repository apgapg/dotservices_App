import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

class ClientModel {
  List<ClientItem> list;

  ClientModel._internal(this.list);

  factory ClientModel.fromJson(dynamic json) {
    return ClientModel.fromMapList(list: json as List);
  }

  factory ClientModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return ClientItem.fromJson(item);
    }).toList();
    return ClientModel._internal(items);
  }
}

@JsonSerializable()
class ClientItem {
  final String id;
  final String name;
  final String number;
  final String description;
  final String area;
  final List<Area> areas;
  final List<Category> categories;

  ClientItem(
    this.id,
    this.name,
    this.number,
    this.categories,
    this.description,
    this.area,
    this.areas,
  );

  factory ClientItem.fromJson(Map<String, dynamic> json) =>
      _$ClientItemFromJson(json);
}

@JsonSerializable()
class Category {
  final String category;

  Category(this.category);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@JsonSerializable()
class Area {
  final String area;

  Area(this.area);

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}

class AdvModel {
  List<Advertisement> list;

  AdvModel._internal(this.list);

  factory AdvModel.fromJson(dynamic json) {
    return AdvModel.fromMapList(list: json as List);
  }

  factory AdvModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Advertisement.fromJson(item);
    }).toList();
    return AdvModel._internal(items);
  }
}

@JsonSerializable()
class Advertisement {
  final String image;
  @JsonKey(defaultValue: false)
  final bool visibility;
  final ClientItem client;

  Advertisement(this.image, this.visibility, this.client);

  factory Advertisement.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementFromJson(json);
}
