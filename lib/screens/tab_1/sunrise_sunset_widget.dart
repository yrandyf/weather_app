import 'package:flutter/material.dart';
import '/util/time_stamp_convertors.dart';
import '/models/current.dart';

Widget SunRiseSunSetWidget(context, WeatherResponse _weatherResponse) {
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
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey),
                )),
                Container(
                    child: Text(
                  "${getTimeFromTimestamp(_weatherResponse.locationDetails.sunrise)}",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                ))
              ],
            )),
            Expanded(
                child: Column(
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
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey),
                )),
                Container(
                    child: Text(
                  "${getTimeFromTimestamp(_weatherResponse.locationDetails.sunset)}",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                ))
              ],
            ))
          ],
        ),
      ),
    ),
  );
}
