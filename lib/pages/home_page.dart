// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
// import 'package:weather_app/pages/search.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_services.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  WeatherModel? weatherData;
  String? CityName;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      body: weatherData == null
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 800,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/b2.jpg"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    margin: EdgeInsets.only(left: 40, top: 20),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xff20e0e5),
                        )),
                    child: Center(
                      child: TextField(
                        controller: textEditingController,
                        style: TextStyle(color: Colors.white),
                        onSubmitted: (data) async {
                          CityName = data;

                          WeatherService service = WeatherService();
                          WeatherModel weather =
                              await service.getWeather(cityName: CityName!);
                          // weatherData = weather;
                          // Navigator.pushReplacementNamed(context, 'search');
                          Provider.of<WeatherProvider>(context, listen: false)
                              .weatherData = weather;

                          print(weather);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xff20e0e5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Color(0xff20e0e5),
                              ),
                              onPressed: () {
                                textEditingController.clear();
                              },
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Color(0xff20e0e5),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (weatherData?.condition == 'Sunny')
                        Container(
                          width: double.infinity,
                          height: 800,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/sunny.jpg"),
                                  fit: BoxFit.cover)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              width: 500,
                              height: 760,
                              color: Colors.grey.withOpacity(.2),
                            ),
                          ),
                        )
                      else if (weatherData?.condition == 'Light rain shower' ||
                          weatherData?.condition == 'Heavy rain')
                        Container(
                          width: double.infinity,
                          height: 800,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/rainy.jpg"),
                                  fit: BoxFit.cover)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              width: 500,
                              height: 760,
                              color: Colors.transparent.withOpacity(.1),
                            ),
                          ),
                        )
                      else if (weatherData?.condition == 'Clear')
                        Container(
                          width: double.infinity,
                          height: 800,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/snow.jpg"),
                                  fit: BoxFit.cover)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              width: 500,
                              height: 760,
                              color: Colors.grey.withOpacity(.2),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          height: 800,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/deafult.jpg"),
                                  fit: BoxFit.cover)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              width: 500,
                              height: 760,
                              color: Colors.grey.withOpacity(.2),
                            ),
                          ),
                        ),
                      Positioned(
                          top: 300,
                          left: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${CityName}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                weatherData!.date,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          )),
                      Positioned(
                          bottom: 270,
                          left: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (weatherData?.condition == 'Sunny')
                                Icon(
                                  Icons.sunny,
                                  color: Colors.amber,
                                  size: 40,
                                )
                              else if (weatherData?.condition ==
                                      'Light rain shower' ||
                                  weatherData?.condition == 'Heavy rain')
                                Icon(
                                  Icons.cloudy_snowing,
                                  size: 30,
                                  color: Colors.white,
                                )
                              else if (weatherData?.condition == 'Clear')
                                Icon(
                                  Icons.cloud,
                                  size: 30,
                                  color: Colors.white,
                                )
                              else
                                Icon(
                                  Icons.sunny_snowing,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                '${weatherData?.avertemp}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "max : ${weatherData?.maxtemp} \n min : ${weatherData?.mintemp}",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                      Positioned(
                          bottom: 150,
                          left: 150,
                          right: 50,
                          child: Text(
                            weatherData?.condition ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                        top: 60,
                        child: Container(
                          margin: EdgeInsets.only(left: 40, top: 20),
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(color: Colors.white),
                              onSubmitted: (data) async {
                                CityName = data;

                                WeatherService service = WeatherService();
                                WeatherModel weather = await service.getWeather(
                                    cityName: CityName!);
                                Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .weatherData = weather;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      textEditingController.clear();
                                    },
                                  ),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
