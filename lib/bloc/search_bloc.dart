import 'dart:convert';
import 'dart:io';

import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/utils/ApiEndpint.dart';
import 'package:dot_my_services/utils/api_helper.dart';
import 'package:dot_my_services/utils/stream_response.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final _dataSubject = BehaviorSubject<List<Category>>(seedValue: null);

  get dataStream => _dataSubject.stream;

  SearchBloc();

  void initData() {
    fetchData();
  }

  void fetchData() async {
    try {
      _dataSubject.sink.add(null);
      var response = await apiHelper.get(endpoint: ApiEndpoint.categories);
      if (response.isSuccess) {
        var model = CategoryModel.fromMapList(list: json.decode(response.body));
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

  dispose() {
    _dataSubject.close();
  }
}
