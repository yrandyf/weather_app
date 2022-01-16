import 'package:flutter/material.dart';
import 'package:weather_app2/util/string_extensions.dart';
import '/util/get_images.dart';
import '/models/current.dart';
import '/data/data_service.dart';
import '/util/time_stamp_convertors.dart';
import '/models/forcast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget detailedHourlyforcastList(Forecast _forecast) {
  return ListView.builder(
    padding: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
    shrinkWrap: true,
    itemCount: _forecast.hourly.length,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Text(
                          "UV index: ${_forecast.hourly[index].uvi}",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 1),
                        child: Text(
                          "Humidity: ${_forecast.hourly[index].humidity}%",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 1),
                        child: Text(
                          "Visbility: ${_forecast.hourly[index].visibility}m",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 1),
                        child: Text(
                          "Cloudiness: ${_forecast.hourly[index].clouds}%",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: getIcons(_forecast.hourly[index].icon),
                      ),
                      Container(
                          child: Text(
                        "${_forecast.hourly[index].description.capitalizeFirstOfEach}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 12),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // padding: EdgeInsets.all(10),
                          child: Text(
                            "${getTimeFromTimestamp(_forecast.hourly[index].dt)}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.tint,
                      size: 15, color: Theme.of(context).primaryColorDark),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Probability of Rain is: ${_forecast.hourly[index].precipitation}%",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.subtitle1,
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

Widget getdetailedHourlyforcast({required WeatherResponse weatherResponse}) {
  Forecast _forcast;
  final _dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error Occured!");
        } else {
          return detailedHourlyforcastList(_forcast);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: _dataService.getForecast(weatherResponse),
  );
}
