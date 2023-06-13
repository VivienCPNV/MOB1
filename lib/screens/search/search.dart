import 'package:cloudy/widgets/weather_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final textEditingController = TextEditingController();
  String? cityName;
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  size: 25.0,
                  color: Colors.white,
                ),
              )
            ]),
        const SizedBox(height: 20),
        TextField(
          controller: textEditingController,
          onTap: () {},
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_pin,
                color: Colors.grey.shade500,
              ),
              hintText: "Enter a location you would want the weather from",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        const SizedBox(height: 25),
        TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.yellow.shade800),
            ),
            onPressed: () {
              setState(() {
                cityName = textEditingController.value.text;
              });
            },
            child: const Text('Search',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ))),
        if (cityName != null && cityName != "") WeatherWidget(city: cityName),
      ],
    );
  }
}
