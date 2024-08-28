import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  WeatherService({required this.dio});
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '11a4603114524911acd154955241608';
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio.get(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops! there was an error try later ';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops! there was an error try later ');
    }
  }
}
