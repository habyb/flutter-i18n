import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteri18n/components/error_view.dart';
import 'package:flutteri18n/components/progress/progress_view.dart';
import 'i18n_cubit.dart';
import 'i18n_messages.dart';
import 'i18n_state.dart';

typedef Widget I18NWidgetCreator(I18NMessages messages);

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  I18NLoadingView(this._creator);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
        builder: (context, state) {
      if (state is InitI18NMessagesState ||
          state is LoadingI18NMessagesSatate) {
        return ProgressView(message: 'Loaging...');
      }
      if (state is LoadedI18NMessagesState) {
        final messages = state.messages;
        return _creator.call(messages);
      }
      return ErrorView('Erro buscando mensagens da tela');
    });
  }
}
