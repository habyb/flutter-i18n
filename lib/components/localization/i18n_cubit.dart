import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteri18n/components/localization/i18n_state.dart';
import 'package:flutteri18n/http/webclients/i18n_webclient.dart';
import 'package:localstorage/localstorage.dart';

import 'i18n_messages.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage =
      new LocalStorage('local_unsecure_version_1.json');
  final String _viewKey;

  I18NMessagesCubit(this._viewKey) : super(InitI18NMessagesState());

  reload(I18NWebClient client) async {
    emit(LoadingI18NMessagesSatate());
    await storage.ready;  
    final items = storage.getItem(_viewKey);

    if (items != null) {
      emit(LoadedI18NMessagesState(I18NMessages(items)));
      return;
    }

    client.findAll().then(saveAndRefresh);
  }

  saveAndRefresh(Map<String, dynamic> messages) {
    storage.setItem(_viewKey, messages);
    print("saving...$_viewKey $messages");
    final state = LoadedI18NMessagesState(I18NMessages(messages));
    emit(state);
  }
}