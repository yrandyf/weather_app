import 'dart:convert';
import '/models/forcast.dart';
import '../models/current.dart';
import '/main.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    String apiKey = 'e29409de9ad6bb5d9cc0556cca521d56';
    final uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    // print(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future getForecast(WeatherResponse weatherResponse) async {
    late Forecast forecast;
    String apiKey = "e82cd2c889d6e07ddd5bba117cc6052d";
    double lat = weatherResponse.locationCordinates.lat;
    double lon = weatherResponse.locationCordinates.lon;
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric");
    final response = await http.get(url);

    forecast = Forecast.fromJson(jsonDecode(response.body));
    // print(response.body);
    return forecast;
  }
}
