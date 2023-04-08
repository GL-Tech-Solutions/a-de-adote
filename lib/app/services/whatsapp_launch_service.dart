import 'package:a_de_adote/app/core/exceptions/launch_url_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappLaunchService {
  WhatsappLaunchService._();

  static Future<void> openWhatsApp(String number, String message) async {
    var urlAndroid = Uri.parse('https://wa.me/55$number/?text=$message');
    if (await canLaunchUrl(urlAndroid)) {
      await launchUrl(
        urlAndroid,
        mode: LaunchMode.externalNonBrowserApplication,
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
