import 'package:http/http.dart' as http;
import 'package:weather/view_models/api_handler/api_utils.dart';

Future<http.Response> makeOneCall(double lat, double lon) async {
  return http.get(
    generateOneCallRequest(lon, lat),
  );
}
