import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteri18n/components/error.dart';
import 'package:flutteri18n/components/progress.dart';

import 'container.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;
  LocalizationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("en");
}

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    assert(values != null);
    assert(values.containsKey(_language));

    return values[_language];
  }
}

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class LoadingI18NMessagesSatate extends I18NMessagesState {
  const LoadingI18NMessagesSatate();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;

  const LoadedI18NMessagesState(this._messages);
}

class I18NMessages {
  final Map<String, String> _messages;

  I18NMessages(this._messages);

  String get (String key) {
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}

class ContactsListCubit extends Cubit<I18NMessagesState> {
  ContactsListCubit() : super(InitContactsListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());
    dao.findAll().then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}

class I18NLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if(state is InitI18NMessagesState || state is LoadingI18NMessagesSatate){
          return ProgressView();
        }
        if(state is LoadedI18NMessagesState){
          return TELA;
        }
        return ErrorView('Erro buscando mensagens da tela');
      }
    ),
  };
}