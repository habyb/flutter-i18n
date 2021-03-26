import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteri18n/components/container.dart';
import 'package:flutteri18n/components/localization.dart';
import 'package:flutteri18n/models/name.dart';
import 'package:flutter/material.dart';
import 'package:flutteri18n/screens/contacts_list.dart';
import 'package:flutteri18n/screens/name.dart';
import 'package:flutteri18n/screens/transactions_list.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Habyb"),
      child: I18NLoadingContainer(
        (messages) => DashboardView(
          DashboardViewLazyI18N(messages),
        ),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  DashboardView(this._i18n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FeatureItem(
                    _i18n.transfer,
                    Icons.monetization_on,
                    onClick: () => _showContacsList(context),
                  ),
                  _FeatureItem(
                    _i18n.transactionFeed,
                    Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                  _FeatureItem(
                    _i18n.changeName,
                    Icons.person_outline,
                    onClick: () => _showChangeName(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showContacsList(BuildContext blocContext) {
  push(blocContext, ContactsListContainer());
}

void _showTransactionsList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}

void _showChangeName(BuildContext blocContext) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: NameContainer(),
      ),
    ),
  );
}
