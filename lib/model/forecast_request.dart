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