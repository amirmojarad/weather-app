const String API_KEY = "29d40fe4d3395e6ac3b6876ca32b7fca";

String getIcons(String iconURL) {
  return "http://openweathermap.org/img/wn/$iconURL@2x.png";
}

String generateOneCallRequest(double lon, double lat) {
  return "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
}
