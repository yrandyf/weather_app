import 'package:flutter/material.dart';
import '/models/current.dart';
import '/data/data_service.dart';
import '/util/get_images.dart';
import '/util/time_stamp_convertors.dart';
import 'package:weather_app2/util/string_extensions.dart';
import '/models/forcast.dart';

Widget dailyForecastList(Forecast _forcast) {
  return Container(
    width: 150,
    child: ListView.builder(
      padding: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
      shrinkWrap: true,
      itemCount: _forcast.daily.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 18, bottom: 18, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${getDateFromTimestamp(_forcast.daily[index].date)}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Temp",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        "${_forcast.daily[index].temp}°",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(child: getIconsSmall(_forcast.daily[index].icon)),
                Expanded(
                  child: Text(
                    "${_forcast.daily[index].description.capitalizeFirstOfEach}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${_forcast.daily[index].low.toInt()} Low",
                        textAlign: TextAlign.right,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${_forcast.daily[index].high.toInt()} High",
                        textAlign: TextAlign.right,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget getDailyforcastList({required WeatherResponse weatherResponse}) {
  Forecast _forcast;
  final _dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error Occured!");
        } else {
          return dailyForecastList(_forcast);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: _dataService.getForecast(weatherResponse),
  );
}
