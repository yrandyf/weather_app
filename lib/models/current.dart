class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int pressure;
  final int humidity;

  TemperatureInfo(
      {required this.temperature,
      required this.feelsLike,
      required this.minTemp,
      required this.maxTemp,
      required this.pressure,
      required this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].toDouble();
    final feelsLike = json['feels_like'].toDouble();
    final minTemp = json['temp_min'].toDouble();
    final maxTemp = json['temp_max'].toDouble();
    final pressure = json['pressure'];
    final humidity = json['humidity'];
    return TemperatureInfo(
        temperature: temperature,
        feelsLike: feelsLike,
        minTemp: minTemp,
        maxTemp: maxTemp,
        pressure: pressure,
        humidity: humidity);
  }
}

class WindInfo {
  final double speed;
  final int deg;

  WindInfo({required this.speed, required this.deg});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'].toDouble();
    final deg = json['deg'];
    return WindInfo(speed: speed, deg: deg);
  }
}

class LocationDetails {
  final String country;
  final int sunrise;
  final int sunset;

  LocationDetails(
      {required this.country, required this.sunrise, required this.sunset});

  factory LocationDetails.fromJson(Map<String, dynamic> json) {
    final country = json['country'];
    final sunrise = json['sunrise'];
    final sunset = json['sunset'];
    return LocationDetails(country: country, sunrise: sunrise, sunset: sunset);
  }
}

class LocationCordinates {
  final double lon;
  final double lat;

  LocationCordinates({required this.lon, required this.lat});

  factory LocationCordinates.fromJson(Map<String, dynamic> json) {
    final lon = json['lon'].toDouble();
    final lat = json['lat'].toDouble();
    return LocationCordinates(lon: lon, lat: lat);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final WindInfo windInfo;
  final LocationDetails locationDetails;
  final LocationCordinates locationCordinates;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.weatherInfo,
      required this.windInfo,
      required this.locationDetails,
      required this.locationCordinates});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final windInfoJson = json['wind'];
    final windInfo = WindInfo.fromJson(windInfoJson);

    final locationDetailsJson = json['sys'];
    final locationDetails = LocationDetails.fromJson(locationDetailsJson);

    final locationCoordinatesJson = json['coord'];
    final locationCordinates =
        LocationCordinates.fromJson(locationCoordinatesJson);

    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        windInfo: windInfo,
        locationDetails: locationDetails,
        locationCordinates: locationCordinates);
  }
}
