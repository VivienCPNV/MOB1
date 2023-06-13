import 'package:flutter/material.dart';
import 'package:cloudy/widgets/weather_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(
                Icons.send,
                size: 25.0,
                color: Colors.white,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: const Icon(
                    Icons.my_location,
                    size: 25.0,
                    color: Colors.white,
                  )),
            ]),
        const Expanded(
          child: WeatherWidget(),
        )
      ],
    );
  }
}
