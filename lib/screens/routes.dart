import 'package:redux/redux.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/weatheria_settings.dart';

class Routes {
  static final routes = (Store<AppState> store) => {
    "/settings": (context) => WeatheriaSettings(store: store,),
  };
}