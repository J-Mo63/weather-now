import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _counter = 0;

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
          return Text(
            "${snapshot.data.temperature.toString()}°C",
            style: Theme.of(context).textTheme.display1,
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
              EdgeInsets.fromLTRB(16, 16, 16, 36),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location'
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.fromLTRB(16, 16, 16, 16),
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
            _counter++;
          });
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}


class ForecastRequest {
  final String summary;
  final double temperature;
  final double windSpeed;

  ForecastRequest({this.summary, this.temperature, this.windSpeed});

  factory ForecastRequest.fromJson(Map<String, dynamic> json) {
    return ForecastRequest(
      summary: json['currently']['summary'],
      temperature: json['currently']['temperature'].toDouble(),
      windSpeed: json['currently']['windSpeed'],
    );
  }
}