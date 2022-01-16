import 'package:flutter/material.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/icon/forecast.png',
              width: 150,
            ),
          ),
          const Center(
            child: Text("Search a city name!"),
          ),
        ],
      ),
    );
  }
}
