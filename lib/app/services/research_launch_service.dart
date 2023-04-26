import 'package:url_launcher/url_launcher.dart';
import '../core/exceptions/launch_url_exception.dart';

class ResearchLaunchService {
  ResearchLaunchService._();

  static Future<void> openForm() async {
    var urlAndroid = Uri.parse(
        'https://docs.google.com/forms/d/1lNCGPiqkXMzJC0hK5CTtg7J8Vpd6-MkMuuSMcsKQhTE/edit?ts=6442e985');
    if (await canLaunchUrl(urlAndroid)) {
      await launchUrl(
        urlAndroid,
      );
    } else {
      throw LaunchUrlException('Não foi possível carregar o WhatsApp.');
    }
  }
}
