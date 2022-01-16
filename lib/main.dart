import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '/models/forcast.dart';
import 'Screens/tab_1/main_weather_results.dart';
import 'Screens/tab_2/hourly_forecast.dart';
import 'Screens/tab_3/daily_forecast.dart';
import 'Screens/tab_4/detailed_daily_forecast.dart';
import 'Screens/tab_5/detailed_hourly_forecast.dart';
import 'data/data_service.dart';
import 'models/current.dart';
import 'util/empty_screen.dart';
import 'util/get_location.dart';
import 'package:get/get.dart';
import 'util/theme_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? weatherResponse;
  Forecast? forecast;

  String location = '';
  String cityName = '';

  RxBool _isLightTheme = false.obs;

  // LocationCoordinatesTranslator-------------------------------------------------------------------------------
  Future<void> getAddressFromCoordinates(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    cityName = '${place.locality}';
    print(place.locality);
    final fresponse = await _dataService.getWeather(place.locality.toString());
    setState(() {
      weatherResponse = fresponse;
    });
    await _dataService.getForecast(weatherResponse!);
    print(weatherResponse);
  }

  // ---------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: [
                    ObxValue(
                      (data) => Switch(
                        activeThumbImage:
                            const AssetImage('assets/icons/lightm.png'),
                        inactiveThumbImage:
                            const AssetImage('assets/icons/darkm.png'),
                        activeColor: Colors.white70,
                        value: _isLightTheme.value,
                        onChanged: (val) {
                          _isLightTheme.value = val;
                          Get.changeThemeMode(
                            _isLightTheme.value
                                ? ThemeMode.light
                                : ThemeMode.dark,
                          );
                        },
                      ),
                      false.obs,
                    ),
                  ],
                  title: const Text('ExactWeather'),
                  pinned: true,
                  floating: true,
                  bottom: const TabBar(
                    indicatorWeight: 5,
                    isScrollable: true,
                    tabs: [
                      Tab(icon: Icon(Icons.cloud), child: Text('Current')),
                      Tab(
                          icon: Icon(Icons.timelapse_sharp),
                          child: Text('Hourly')),
                      Tab(
                          icon: Icon(Icons.date_range_sharp),
                          child: Text('Daily')),
                      Tab(
                          icon: Icon(Icons.thermostat_outlined),
                          child: Text('Daily Detailed')),
                      Tab(
                          icon: Icon(Icons.thermostat_outlined),
                          child: Text('Hourly Detailed')),
                    ],
                  ),
                ),
              ];
            },
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                      controller: _cityTextController,
                                      decoration: InputDecoration(
                                        labelText: 'City Name',
                                        suffix: IconButton(
                                          iconSize: 30,
                                          onPressed: _search,
                                          icon: const Icon(Icons.search_sharp,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 5),
                                      child: IconButton(
                                        iconSize: 40,
                                        color: Colors.blue,
                                        onPressed: getLocationButton,
                                        hoverColor: Colors.grey,
                                        icon:
                                            const Icon(Icons.my_location_sharp),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          // Tab 1
                          if (weatherResponse != null)
                            WeatherResultsWidget(
                              weatherResponse: weatherResponse,
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Tab 2
                  if (weatherResponse != null)
                    getforcastViewsHourly(weatherResponse: weatherResponse!)
                  else
                    const EmptyScreenWidget(),
                  //  Tab 3
                  if (weatherResponse != null)
                    getDailyforcastList(weatherResponse: weatherResponse!)
                  else
                    const EmptyScreenWidget(),
                  //  Tab 4
                  if (weatherResponse != null)
                    getdetailedDailyforcast(weatherResponse: weatherResponse!)
                  else
                    const EmptyScreenWidget(),
                  //  Tab 5
                  if (weatherResponse != null)
                    getdetailedHourlyforcast(weatherResponse: weatherResponse!)
                  else
                    const EmptyScreenWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    final fresponse = await _dataService.getWeather(_cityTextController.text);

    setState(() {
      weatherResponse = fresponse;
    });
    final forecastResponse = await _dataService.getForecast(weatherResponse!);
  }

  getLocationButton() async {
    Position position = await getLocationCoordinates();
    getAddressFromCoordinates(position);
    location = ' ${position.latitude} ,  ${position.longitude}';
  }
}
