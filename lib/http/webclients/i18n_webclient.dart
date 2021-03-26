import 'dart:convert';

import 'package:flutteri18n/http/webclient.dart';
import 'package:http/http.dart';

const MESSAGES_URI =
    'https://gist.githubusercontent.com/habyb/295667924d7a8cc7c0fc72c0d30cd25f/raw/7250acd50fb0902284b7ad8b11d89da574af8e4c/';

class I18NWebClient {
  final String _viewKey;

  I18NWebClient(this._viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get(Uri.parse('$MESSAGES_URI$_viewKey.json'));
    print(Uri.parse('$MESSAGES_URI$_viewKey.json'));
    final Map<String, dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson;
  }
}
