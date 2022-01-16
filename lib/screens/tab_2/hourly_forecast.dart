import 'package:flutter/material.dart';
import 'package:weather_app2/util/string_extensions.dart';
import '/util/get_images.dart';
import '/models/current.dart';
import '/util/time_stamp_convertors.dart';
import '/models/forcast.dart';
import '/data/data_service.dart';

Widget hourlyForecastList(Forecast _forecast) {
  return Container(
      height: 150,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
          scrollDirection: Axis.vertical,
          itemCount: _forecast.hourly.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 15, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Temp",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            "${_forecast.hourly[index].temp}°",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Feels Like: ${_forecast.hourly[index].feelsLike}°",
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Precipitation: ${_forecast.hourly[index].precipitation}°",
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          getIcons(_forecast.hourly[index].icon),
                          Text(
                            "${_forecast.hourly[index].description.capitalizeFirstOfEach}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(
                        "${getTimeFromTimestamp(_forecast.hourly[index].dt)}",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            );
          }));
}

Widget getforcastViewsHourly({required WeatherResponse weatherResponse}) {
  Forecast _forcast;
  final _dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error Occured!");
        } else {
          return hourlyForecastList(_forcast);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: _dataService.getForecast(weatherResponse),
  );
}
