import 'package:flutter/material.dart';
import 'package:flutteri18n/components/localization/eager_localization.dart';
import 'package:flutteri18n/components/localization/i18n_messages.dart';

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String get transfer => _messages.get("transfer");

  String get transactionFeed => _messages.get("transactionFeed");

  String get changeName => _messages.get("changeName");
}

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer => localize({"pt-br": "Transferir", "en": "Tranfer"});

  String get transactionFeed =>
      localize({"pt-br": "Transaçãoes", "en": "Transaction Feed"});

  String get changeName =>
      localize({"pt-br": "Mudar Nome", "en": "Change Name"});
}