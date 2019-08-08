import 'package:dot_my_services/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static void onPhoneTap(String mobile) async {
    var url = 'tel:$mobile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt call');
    }
  }

  static void onMailTap() async {
    var url = 'mailto:dotcompany@gmail.com?subject=Information&body=Hi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt open mail');
    }
  }

  static void onFormTap() async {
    var url = 'https://forms.gle/AMK412nHZUdHP7Nd9';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt open link');
    }
  }
}
