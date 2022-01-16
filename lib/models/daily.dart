class Daily {
  final int date;
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final double pressure;
  final double humidity;
  final double wind;
  final String icon;
  final int sunrise;
  final int sunset;
  final double dailyMorn;
  final double dailyNight;
  final double dailyDay;
  final double pop;
  final double uvi;
  final int cloudiness;
  final double feelsLikeDay;
  final double feelsLikeMorn;
  final double feelsLikeNight;

  Daily(
      {required this.date,
      required this.temp,
      required this.feelsLike,
      required this.low,
      required this.high,
      required this.description,
      required this.pressure,
      required this.humidity,
      required this.wind,
      required this.icon,
      required this.sunrise,
      required this.sunset,
      required this.dailyDay,
      required this.dailyMorn,
      required this.dailyNight,
      required this.pop,
      required this.uvi,
      required this.cloudiness,
      required this.feelsLikeDay,
      required this.feelsLikeMorn,
      required this.feelsLikeNight});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
        date: json['dt'].toInt(),
        temp: json['temp']['day'].toDouble(),
        feelsLike: json['feels_like']['day'].toDouble(),
        low: json['temp']['min'].toDouble(),
        high: json['temp']['max'].toDouble(),
        description: json['weather'][0]['description'],
        pressure: json['pressure'].toDouble(),
        humidity: json['humidity'].toDouble(),
        wind: json['wind_speed'].toDouble(),
        icon: json['weather'][0]['icon'],
        sunrise: json['sunrise'].toInt(),
        sunset: json['sunset'].toInt(),
        dailyDay: json['temp']['day'].toDouble(),
        dailyMorn: json['temp']['morn'].toDouble(),
        dailyNight: json['temp']['night'].toDouble(),
        pop: json['pop'].toDouble(),
        uvi: json['uvi'].toDouble(),
        cloudiness: json['clouds'],
        feelsLikeDay: json['feels_like']['day'].toDouble(),
        feelsLikeMorn: json['feels_like']['morn'].toDouble(),
        feelsLikeNight: json['feels_like']['night'].toDouble());
  }
}
