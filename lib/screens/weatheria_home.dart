import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/widgets/weather_error.dart';
import 'package:weatheria/screens/widgets/weather_helper.dart';
import 'package:weatheria/screens/widgets/weather_info.dart';
import 'package:weatheria/screens/widgets/weather_loading.dart';

class WeatheriaHome extends StatefulWidget {
  WeatherFetch fetchAction;

  WeatheriaHome({this.fetchAction});

  @override
  _WeatheriaHomeState createState() => _WeatheriaHomeState();
}

class _WeatheriaHomeState extends State<WeatheriaHome> {
  @override
  void dispose() {
    super.dispose();
    widget.fetchAction.closeReactiveStream();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      onInit: (store) {
        store.dispatch(widget.fetchAction.setFetchType(FetchType.GPS));
      },
      distinct: true,
      converter: (store) => store.state,
      builder: (context, state) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [state.colorBegin(), state.colorEnd()]),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<Status>(
                      initialData: Status.IDLE,
                      stream: widget.fetchAction.stream,
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (!snapshot.hasData || snapshot.data == Status.LOADING)
                          return WeatherLoading();
                        else if (snapshot.data == Status.IDLE)
                          return WeatherHelper();
                        else if (snapshot.data == Status.ERROR)
                          return WeatherError();
                        else if (snapshot.data == Status.COMPLETE)
                          return WeatherInfo(weather: state.weatherState);
                        else
                          return Container();
                      }),
                )
              ],
            )),
      ),
    );
  }
}
