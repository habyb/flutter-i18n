import 'dart:convert';

import 'package:flutteri18n/http/webclient.dart';
import 'package:http/http.dart';

const MESSAGES_URI =
    'https://gist.githubusercontent.com/habyb/295667924d7a8cc7c0fc72c0d30cd25f/raw/9b16dba95ff5309947b691803319c42dded072f5/i18n.json';

class I18NWebClient {
  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get(Uri.parse(MESSAGES_URI));
    final Map<String, dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson;
  }
}
