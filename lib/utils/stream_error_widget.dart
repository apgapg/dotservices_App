import 'package:dot_my_services/utils/stream_response.dart';
import 'package:dot_my_services/widgets/internet_not_available.dart';
import 'package:dot_my_services/widgets/server_error_widget.dart';
import 'package:dot_my_services/widgets/unknown_error_widget.dart';
import 'package:flutter/material.dart';

class StreamErrorWidget extends StatelessWidget {
  final dynamic streamError;
  final VoidCallback onTap;

  StreamErrorWidget(this.streamError, this.onTap);

  @override
  Widget build(BuildContext context) {
    Widget widget = getWidget();
    return Center(
      child: widget,
    );
  }

  Widget getWidget() {
    if (streamError is StreamError) {
      var error = streamError as StreamError;
      if (error.type == ErrorType.Offline)
        return InternetNotAvailable(onTap);
      else if (error.type == ErrorType.ServerError)
        return ServerErrorWidget(error.msg, onTap);
      else
        return UnknownErrorWidget(onTap);
    } else {
      return UnknownErrorWidget(onTap);
    }
  }
}
