import 'package:a_de_adote/app/core/exceptions/launch_url_exception.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsappLaunchService {
  static Future<void> openWhatsApp(String number, String message) async {
    var urlAndroid = ('https://wa.me/55$number/?text=$message');
    if (await canLaunchUrlString(urlAndroid)) {
      await launchUrlString(
        urlAndroid,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      throw LaunchUrlException('Não foi possível carregar o WhatsApp.');
    }
  }
}
