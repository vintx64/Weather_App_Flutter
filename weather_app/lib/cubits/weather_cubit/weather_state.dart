import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSucess extends WeatherState {
  WeatherModel weatherModel;
  WeatherSucess({required this.weatherModel});
}

class WeatherFaliure extends WeatherState {}
