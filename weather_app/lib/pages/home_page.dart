import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  final WeatherModel? weatherData;

  const HomePage({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search))
      ], title: const Text('Weather App')),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherSucess) {
          return SucessPage(weatherData: state.weatherModel);
        } else if (state is WeatherFaliure) {
          return const Center(
            child: Text('Something Went Wrong Please try again'),
          );
        } else {
          return const DeafultPage();
        }
      }),
    );
  }
}

class DeafultPage extends StatelessWidget {
  const DeafultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'start searching weather info by typing city name.',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'click search button above. 🔍',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    ));
  }
}

class SucessPage extends StatelessWidget {
  const SucessPage({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        weatherData!.getThemeColor(),
        weatherData!.getThemeColor()[300]!,
        weatherData!.getThemeColor()[100]!
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            'Updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style: const TextStyle(fontSize: 22),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                '${weatherData!.temp.toInt()}',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text('maxTemp: ${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp: ${weatherData!.minTemp.toInt()}')
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            weatherData!.weatherStateName,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
