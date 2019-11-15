import 'dart:html' as html;

import 'package:dot_my_services/utils/toast_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static void onPhoneTap(String mobile) async {
    var url = 'tel:$mobile';
    if (kIsWeb) {
      html.window.open(url, "Contact Us");
    } else if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt call');
    }
  }

  static void onMailTap() async {
    var url = 'mailto:dotcompany@gmail.com?subject=Information&body=Hi';
    if (kIsWeb) {
      //html.window.open(url, "Mail Us");
    } else if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt open mail');
    }
  }

  static void onFormTap() async {
    var url = 'https://forms.gle/AMK412nHZUdHP7Nd9';
    if (kIsWeb) {
      html.window.open(url, "Registration");
    } else if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt open link');
    }
  }
}
