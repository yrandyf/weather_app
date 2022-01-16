import 'package:flutter/material.dart';
import '/data/data_service.dart';
import '/models/hourly.dart';
import '/models/forcast.dart';
import '/util/time_stamp_convertors.dart';
import '/models/current.dart';

Widget WeatherDetailsWidget4(context, Forecast _forecast) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Card(
      elevation: 10,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "UV index",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_forecast.hourly[1].uvi}",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "Dew Point",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_forecast.hourly[1].dewPoint} °C",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      "A.Visibility",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_forecast.hourly[1].visibility} m",
                      // textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget getWeatherDetailsWidget4({required WeatherResponse weatherResponse}) {
  Forecast _forcast;
  final _dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error Occured!");
        } else {
          return WeatherDetailsWidget4(context, _forcast);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: _dataService.getForecast(weatherResponse),
  );
}
