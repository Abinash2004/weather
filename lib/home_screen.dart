import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather/secrets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var city = TextEditingController();
  String cityName = 'Delhi';
  Future getWeatherScreen() async {
    try{
      final result = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      ); 
      final data = jsonDecode(result.body);
      if(data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    }catch(error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen =  MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 37, 62),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(cityName,
          style: const TextStyle(
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            setState(() {});
          }, icon: const Icon(Icons.refresh)),
        ],
        leading: IconButton(
          onPressed: (){
            showDialog(context: context, builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0),
                            ),
                child: AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 30, 33, 36),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: city,
                        style: const TextStyle( 
                        color: Color.fromARGB(255, 181, 181, 181),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Enter City Name',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 181, 181, 181)),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          searchButton(true,(){
                            Navigator.pop(context);
                          }),
                          const SizedBox(width: 20,),
                          searchButton(false,(){
                            cityName = city.text;
                            Navigator.pop(context);
                          }),
                        ],
                      ),
                      const Center(
                        child: Text('Credit - Abinash',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
          icon: const Icon(Icons.location_pin),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getWeatherScreen(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 20),
                  Text('LOADING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 181, 181, 181),
                  ))
                ],
              )
            );
          }
          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString(),
            style: const TextStyle(
              color: Color.fromARGB(255, 181, 181, 181),
              fontSize: 20,
                    fontWeight: FontWeight.bold,
            ),));
          }
          
          final data = snapshot.data! ;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'].toString();
          final windSpeed = data['list'][0]['wind']['speed'].toString();
          final pressure = data['list'][0]['main']['pressure'].toString();

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    weatherContainer1(currentTemp,currentSky),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Hourly Forecast',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 181, 181, 181),
                          ),
                        ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(int i = 0; i < 5; i++) 
                            weatherContainer2(
                              screen,
                              data['list'][i+1]['weather'][0]['main'],
                              DateFormat.Hm().format(DateTime.parse(data['list'][i+1]['dt_txt'].toString())),
                              data['list'][i+1]['main']['temp'].toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Additional Information',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 181, 181, 181),
                          ),
                        ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        weatherContainer3(screen,Icons.water_drop,'Humidity',humidity),
                        weatherContainer3(screen,Icons.air, 'Wind Speed',windSpeed),
                        weatherContainer3(screen,Icons.beach_access, 'Pressure',pressure),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}