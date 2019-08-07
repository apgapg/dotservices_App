import 'dart:convert';
import 'dart:io';

import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/utils/ApiEndpint.dart';
import 'package:dot_my_services/utils/api_helper.dart';
import 'package:dot_my_services/utils/stream_response.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _dataSubject = BehaviorSubject<List<ClientItem>>(seedValue: null);
  final _advDataSubject = BehaviorSubject<List<Advertisement>>(seedValue: null);

  get dataStream => _dataSubject.stream;

  get advStream => _advDataSubject.stream;

  void initData() {
    fetchData();
    fetchAdvData();
  }

  void fetchData() async {
    try {
      _dataSubject.sink.add(null);
      var response = await apiHelper.get(endpoint: ApiEndpoint.client);
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
}
