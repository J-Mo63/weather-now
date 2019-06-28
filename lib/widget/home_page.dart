import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_now/model/forecast_request.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//  int _counter = 0;

  final String darkSkyApi = 'https://api.darksky.net/forecast/24e1c66bc691f3a64110e0a141d3e70f/37.8267,-122.4233?exclude=flags,alerts,daily,hourly,minutely&units=si';

  Future<ForecastRequest> fetchPost() async {
    final response = await http.get(darkSkyApi);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return ForecastRequest.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  FutureBuilder<ForecastRequest> getTemperatureWidget() {
    return FutureBuilder<ForecastRequest>(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "${snapshot.data.summary}",
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                "${snapshot.data.temperature.toString()}°C",
                style: Theme.of(context).textTheme.display2,
              ),
              Text(
                "${snapshot.data.windSpeed}km/hour windspeed",
                style: Theme.of(context).textTheme.body1,
              ),
            ]
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              EdgeInsets.fromLTRB(15, 15, 15, 25),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location'
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Text(
                "Current Temperature in Los Angeles, CA",
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            getTemperatureWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            build(context);
          });
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}