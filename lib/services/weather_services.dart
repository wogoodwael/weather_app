import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '97ece4216cfe4999884200844231103';
  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri uri = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7&alerts=yes');
    http.Response response = await http.get(uri);
    Map<String, dynamic> data = jsonDecode(response.body);
    WeatherModel weatherModel = WeatherModel.fromJson(data);
    return weatherModel;
    // print('City Name : ${data['location']['localtime']} ');
  }
}
