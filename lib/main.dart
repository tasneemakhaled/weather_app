import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(InitialState()),
      child: CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: getThemeColor(
                  BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel
                      ?.weatherStatus),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: HomeView(),
          );
        },
      );
    });
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null)
    return Colors.blue;
  else if (condition == 'Sunny') {
    return Colors.orange;
  } else if (condition == 'Cloudy' || condition == 'Overcast') {
    return Colors.grey;
  } else if (condition == 'Mist') {
    return Colors.blueGrey;
  } else if (condition.contains('rain') ||
      condition.contains('snow') ||
      condition.contains('sleet') ||
      condition.contains('drizzle')) {
    return Colors.blue;
  } else if (condition.contains('thunder')) {
    return Colors.yellow;
  } else {
    return Colors.grey;
  }
}
