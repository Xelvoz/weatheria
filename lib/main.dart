import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatheria/app.dart';
import 'package:weatheria/redux/appstate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env');

  final store = new Store<AppState>(
    initialState: AppState.initialState(),
    stateObservers: [StateLogger()],
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(Weatheria(store: store));
}

class StateLogger extends StateObserver<AppState> {
  @override
  void observe(ReduxAction action, AppState stateIni, AppState stateEnd, int dispatchCount) {
    print("******************");
    print("Triggered Action: " + action.toString());
    print(stateIni);
    print(stateEnd);
    print("******************");
  }
}
