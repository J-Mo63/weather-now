class ForecastRequest {
  final Forecast current;
  final List<Forecast> hourly;

  ForecastRequest({this.current, this.hourly});

  factory ForecastRequest.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyJson = json['hourly']['data'];

    return ForecastRequest(
      current: Forecast.fromJson(json['currently']),
      hourly: hourlyJson.map((i)=>Forecast.fromJson(i)).toList(),
    );
  }
}

class Forecast {
  final String summary;
  final double temperature;
  final double windSpeed;

  Forecast({this.summary, this.temperature, this.windSpeed});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      summary: json['summary'],
      temperature: json['temperature'].toDouble(),
      windSpeed: json['windSpeed'].toDouble(),
    );
  }
}