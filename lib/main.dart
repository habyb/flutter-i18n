import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteri18n/screens/dashboard.dart';

import 'components/theme.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(FlutterI18n());
}

class LogObserver extends BlocObserver{
  @override
    void onChange(Cubit cubit, Change change) {
      print('${cubit.runtimeType} > $change');
      super.onChange(cubit, change);
    }
}

class FlutterI18n extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();
    return MaterialApp(
      theme: bytebankTheme,
      home: DashboardContainer(),
    );
  }
}
