import 'package:url_launcher/url_launcher.dart';

import '../core/exceptions/launch_url_exception.dart';

class ResearchLaunchService {
  ResearchLaunchService._();

  static Future<void> openForm() async {
    var urlAndroid = Uri.parse('https://flutter.dev/');
    if (await canLaunchUrl(urlAndroid)) {
      await launchUrl(
        urlAndroid,
        //mode: LaunchMode.externalApplication,
      );
    } else {
      throw LaunchUrlException('Não foi possível carregar o WhatsApp.');
    }
    /*try {
      await launchUrl(
        urlAndroid,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } on Exception catch (e) {
      throw LaunchUrlException(e.toString());
    }*/
  }
}
