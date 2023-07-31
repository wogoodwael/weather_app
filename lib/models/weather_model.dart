class WeatherModel {
   String date;
   double maxtemp;
   double mintemp;
   double avertemp;
   String astro;
   String condition;

  WeatherModel(
      {required this.date,
      required this.maxtemp,
      required this.mintemp,
      required this.astro,
      required this.condition,required this.avertemp});

  factory WeatherModel.fromJson(dynamic data) {
    var jsondata = data['forecast']['forecastday'][0];

    return WeatherModel(
      date: data['location']['localtime'],
      maxtemp: jsondata['day']['maxtemp_c'],
      mintemp: jsondata['day']['mintemp_c'],
      astro: jsondata['astro']['sunrise'],
      condition: jsondata['day']['condition']['text'], 
      avertemp: jsondata['day']['avgtemp_c'],
    );
  }
  @override
  String toString() {
    return 'date is $date , maxtemp  = $maxtemp , mintemp = $mintemp, estro $astro , condition = $condition , avertemp=$avertemp';
  }
}
