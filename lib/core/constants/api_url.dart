const String apiKey = "1ed73d5036b030578d407e9cc19af66e";

String weatherApiUrl(double lat, double lon) {
  const primaryUrl = 'https://api.openweathermap.org';
  const path = '/data/3.0/onecall';
  final queryString =
      '?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely';

  final finalUrl = primaryUrl + path + queryString;
  return finalUrl;
}

String areaApiUrl(String area) {
  const int limit = 5;
  const String baseUrl = 'https://api.openweathermap.org/geo/1.0/direct';
  final queries = '?q=$area&limit=$limit&appid=$apiKey';

  return baseUrl + queries;
}
