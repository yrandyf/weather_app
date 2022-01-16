import 'package:flutter/material.dart';
import '/util/time_stamp_convertors.dart';
import '/models/current.dart';

Widget WeatherDetailsWidget(context, WeatherResponse _weatherResponse) {
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
                      "Wind",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_weatherResponse.windInfo.speed} km/h",
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
                      "Pressure",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_weatherResponse.tempInfo.pressure} hPa",
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
                      "Humidity",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_weatherResponse.tempInfo.humidity}%",
                      textAlign: TextAlign.left,
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
