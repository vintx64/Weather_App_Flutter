import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherService weatherService;
  String? cityName;
  WeatherModel? weatherModel;
  WeatherCubit(this.weatherService) : super(WeatherInitial());

  void getWeather({required String cityName}) async {
    emit(WeatherLoading());

    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSucess(weatherModel: weatherModel!));
    } on Exception {
      emit(WeatherFaliure());
    }
  }
}
