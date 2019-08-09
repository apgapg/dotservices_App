import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/model/location_model.dart';
import 'package:dot_my_services/utils/ApiEndpint.dart';
import 'package:dot_my_services/utils/api_helper.dart';
import 'package:dot_my_services/utils/log_utils.dart';
import 'package:dot_my_services/utils/stream_response.dart';
import 'package:dot_my_services/utils/top_level.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _dataSubject = BehaviorSubject<List<ClientItem>>(seedValue: null);
  final _advDataSubject = BehaviorSubject<List<Advertisement>>(seedValue: null);

  get dataStream => _dataSubject.stream;

  get advStream => _advDataSubject.stream;

  void initData() {
    fetchData();
    fetchAdvData();
    initLocation();
  }

  void fetchData() async {
    try {
      _dataSubject.sink.add(null);
      var response = await apiHelper.get(endpoint: ApiEndpoint.clients);
      if (response.isSuccess) {
        var model = ClientModel.fromMapList(list: json.decode(response.body));
        _dataSubject.sink.add(model.list);
      } else {
        _dataSubject.addError(StreamError.serverError(response.statusCode));
      }
    } on SocketException catch (e) {
      _dataSubject.addError(StreamError.offline());
    } catch (e) {
      _dataSubject.addError(StreamError.unknownError());
    }
  }

  void fetchAdvData() async {
    try {
      _advDataSubject.sink.add(null);
      var response = await apiHelper.get(endpoint: ApiEndpoint.adv);
      if (response.isSuccess) {
        var model = AdvModel.fromJson(json.decode(response.body));
        _advDataSubject.sink.add(model.list);
      } else {
        _advDataSubject.addError(StreamError.serverError(response.statusCode));
      }
    } on SocketException catch (e) {
      _advDataSubject.addError(StreamError.offline());
    } catch (e) {
      _advDataSubject.addError(StreamError.unknownError());
    }
  }

  dispose() {
    _dataSubject.close();
    _advDataSubject.close();
  }

  void initLocation() async {
    try {
      Position location = await Geolocator().getCurrentPosition();
      var address = "NA";
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemark != null && placemark.isNotEmpty) {
        var list = List<String>();
        if (checkIfNotEmpty(placemark[0].name)) list.add(placemark[0].name);
        if (checkIfNotEmpty(placemark[0].subLocality))
          list.add(placemark[0].subLocality);
        if (checkIfNotEmpty(placemark[0].locality))
          list.add(placemark[0].locality);
        if (checkIfNotEmpty(placemark[0].subAdministrativeArea))
          list.add(placemark[0].subAdministrativeArea);
        if (checkIfNotEmpty(placemark[0].administrativeArea))
          list.add(placemark[0].administrativeArea);
        if (checkIfNotEmpty(placemark[0].postalCode))
          list.add(placemark[0].postalCode);
        if (checkIfNotEmpty(placemark[0].country))
          list.add(placemark[0].country);
        address = list.join(', ');
      }
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var locationModel = LocationModel(
        androidId: androidInfo.androidId,
        latitude: location.latitude,
        longitude: location.longitude,
        accuracy: location.accuracy.toInt(),
        captureTime: 5,
        source: "location 1.3.4",
        time: location.timestamp.millisecondsSinceEpoch.toDouble(),
        capturedAddress: address ?? "NA",
      );
      var body = jsonEncode(locationModel);
      printLog(body);

      var response =
          await apiHelper.post(endpoint: ApiEndpoint.location, body: body);
      if (response.isSuccess) printLog("success");
    } catch (e) {
      printLog(e);
    }
  }
}
