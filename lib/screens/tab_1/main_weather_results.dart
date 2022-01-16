import 'package:flutter/material.dart';
import 'package:weather_app2/util/string_extensions.dart';
import '/models/current.dart';
import 'sunrise_sunset_widget.dart';
import '/data/data_service.dart';
import 'weather_details_widget_4.dart';
import 'weather_details_widget_3.dart';

class WeatherResultsWidget extends StatelessWidget {
  WeatherResultsWidget({
    Key? key,
    required WeatherResponse? weatherResponse,
  })  : _response = weatherResponse,
        super(key: key);

  final WeatherResponse? _response;
  final _dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 10,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.network(_response!.iconUrl,
                              fit: BoxFit.fill),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _response!
                                .weatherInfo.description.capitalizeFirstOfEach,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'M: ${_response!.tempInfo.minTemp}° H: ${_response!.tempInfo.maxTemp}° ',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12.2),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _response!.locationDetails.country,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          _response!.cityName.capitalizeFirstOfEach,
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        Text(
                          '${_response!.tempInfo.temperature}°',
                          style: const TextStyle(
                              fontSize: 34, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Feels Like: ${_response!.tempInfo.feelsLike}° ',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        currentWeatherViews(_response!, context),
      ],
    );
  }
}

Widget currentWeatherViews(
    WeatherResponse _weatherResponse, BuildContext context) {
  WeatherResponse response;

  final dataService = DataService();

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weatherResponse = snapshot.data as WeatherResponse;
        if (_weatherResponse == null) {
          return const Center(
            child: Text("Error Occured!"),
          );
        } else {
          return Column(
            children: [
              SunRiseSunSetWidget(context, _weatherResponse),
              WeatherDetailsWidget(context, _weatherResponse),
              getWeatherDetailsWidget4(weatherResponse: _weatherResponse),
              // weatherDetailsBox(_weather as Weather),
            ],
          );
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: dataService.getWeather(_weatherResponse.cityName),
  );
}
