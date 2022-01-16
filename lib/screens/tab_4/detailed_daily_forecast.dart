import 'package:flutter/material.dart';
import '/models/current.dart';
import '/data/data_service.dart';
import '/util/time_stamp_convertors.dart';
import '/models/forcast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget detailedDailyForecastList(Forecast _forcast) {
  return ListView.builder(
    padding: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
    shrinkWrap: true,
    itemCount: _forcast.daily.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getDateFromTimestamp(_forcast.daily[index].date)}",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 1),
                        child: Text(
                          "Morning: ${_forcast.daily[index].dailyMorn}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Text(
                          "Feels Like: ${_forcast.daily[index].feelsLikeMorn}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 1),
                        child: Text(
                          "Day: ${_forcast.daily[index].dailyDay}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Text(
                          "Feels Like: ${_forcast.daily[index].feelsLikeDay}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 1),
                        child: Text(
                          "Night: ${_forcast.daily[index].dailyNight}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Text(
                          "Feels Like: ${_forcast.daily[index].feelsLikeNight}°",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.wb_sunny_sharp,
                          size: 60,
                          color: Colors.yellow[600],
                        ),
                      ),
                      Container(
                          child: const Text(
                        "Sun Rise",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey),
                      )),
                      Container(
                          child: Text(
                        "${getTimeFromTimestamp(_forcast.daily[index].sunrise)}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 15),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.wb_twilight_sharp,
                            size: 60, color: Colors.grey[500]),
                      ),
                      Container(
                          child: const Text(
                        "Sun Set",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey),
                      )),
                      Container(
                          child: Text(
                        "${getTimeFromTimestamp(_forcast.daily[index].sunset)}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 15),
                      ))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.tint,
                      size: 15, color: Theme.of(context).primaryColorDark),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Probability of Rain is: ${_forcast.daily[index].pop}%",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 17),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget getdetailedDailyforcast({required WeatherResponse weatherResponse}) {
  Forecast _forcast;
  final _dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error Occured!");
        } else {
          return detailedDailyForecastList(_forcast);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: _dataService.getForecast(weatherResponse),
  );
}
