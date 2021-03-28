import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_weather/model/weather_data.dart';
import 'package:i_weather/model/weather_interpretation.dart';
import 'package:i_weather/services/weather_service.dart';
import 'package:numberpicker/numberpicker.dart';

import 'select_location_screen.dart';

// class LocationScreen extends StatefulWidget {
//   final WeatherData weatherData;
//
//   LocationScreen(this.weatherData);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _LocationScreenState();
//   }
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   WeatherData _weatherData;
//
//   @override
//   void initState() {
//     _weatherData = widget.weatherData;
//     //later call to build() will use _watherData
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Location Name:${_weatherData.name}',
//           ),
//           Text(
//             'Temperature(Min/Max):${_weatherData.main.tempMin}/${_weatherData.main.tempMax}',
//           ),
//         ],
//       ),
//     );
//   }
// }

class LocationScreen extends StatefulWidget {
  WeatherData _weatherData;

  LocationScreen(this._weatherData);

  @override
  State<StatefulWidget> createState() {
    return _LocationScreenState();
  }
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherInterpretation _weatherInterpretation = WeatherInterpretation();

  int _weekDayValue = 3;
  int _hourValue = 1;
  WeatherData _weatherData = null;
  WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    _weekDayValue = dateTime.weekday;
    _hourValue = dateTime.hour;
    _weatherData = widget._weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: _weatherInterpretation.getBackgroundGradient(0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Weather',
              style: GoogleFonts.montserrat(
                fontSize: 60.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '${_weatherData.name}',
              style: GoogleFonts.montserrat(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SvgPicture.string(
                    // Icon feather-cloud-rain
                    _weatherInterpretation
                        .getWeatherIcon(_weatherData.weather[0].id),
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NumberPicker(
                        value: _hourValue,
                        minValue: 0,
                        maxValue: 25,
                        axis: Axis.vertical,
                        haptics: true,
                        zeroPad: true,
                        textStyle: TextStyle(color: Colors.white, fontSize: 14),
                        selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textMapper: (numberText) {
                          return "$numberText:00";
                        },
                        onChanged: (value) =>
                            setState(() => _hourValue = value),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 65.0,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: '${_weatherData.main.temp.toInt()}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '°C',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${_weatherData.weather[0].main}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${_weatherData.weather[0].description.toUpperCase()}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text.rich(
              TextSpan(
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text:
                        '${_weatherData.main.tempMin.toInt()}/${_weatherData.main.tempMax.toInt()}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '°C',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NumberPicker(
                  value: _weekDayValue,
                  minValue: 1,
                  maxValue: 7,
                  axis: Axis.horizontal,
                  haptics: true,
                  zeroPad: true,
                  textStyle: TextStyle(color: Colors.white, fontSize: 14),
                  selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textMapper: (numberText) {
                    switch (numberText) {
                      case "1":
                        return "Mon";
                      case "2":
                        return "Tue";
                      case "3":
                        return "Wed";
                      case "4":
                        return "Thu";
                      case "5":
                        return "Fri";
                      case "6":
                        return "Sat";
                      case "7":
                        return "Sun";
                    }
                    return "";
                  },
                  onChanged: (value) => setState(() => _weekDayValue = value),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 22),
                GestureDetector(
                  onTap: () async {
                    String cityName = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SelectLocationScreen();
                    }));
                    if (cityName != null) {
                      WeatherData weatherData = await _weatherService
                          .getWeatherDataByCity(cityName: cityName);
                      if (weatherData != null) {
                        setState(() {
                          _weatherData = weatherData;
                        });
                      }
                    }
                  },
                  child: SizedBox(
                    width: 35.0,
                    height: 41.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          child: SvgPicture.string(
                            // Icon material-location-on
                            '<svg viewBox="100.0 790.0 19.6 28.0" ><path transform="translate(92.5, 787.0)" d="M 17.29999923706055 3 C 11.88199996948242 3 7.5 7.381999969482422 7.5 12.80000019073486 C 7.5 20.15000152587891 17.29999923706055 31 17.29999923706055 31 C 17.29999923706055 31 19.4464111328125 28.62361526489258 21.902099609375 25.09337043762207 C 24.32633972167969 21.61103057861328 27.10000038146973 16.71021842956543 27.10000038146973 12.80000019073486 C 27.10000038146973 7.381999969482422 22.7180004119873 3 17.29999923706055 3 Z M 17.29999923706055 16.30000114440918 C 15.36800003051758 16.30000114440918 13.80000019073486 14.73199939727783 13.80000019073486 12.80000019073486 C 13.80000019073486 10.86800003051758 15.36800003051758 9.300000190734863 17.29999923706055 9.300000190734863 C 19.23200035095215 9.300000190734863 20.79999923706055 10.86800003051758 20.79999923706055 12.80000019073486 C 20.79999923706055 14.73199939727783 19.23200035095215 16.30000114440918 17.29999923706055 16.30000114440918 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            width: 19.6,
                            height: 28.0,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            alignment: Alignment(0.0, -0.09),
                            width: 26.0,
                            height: 26.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF054077),
                            ),
                            child: Text(
                              '3',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 60),
                SvgPicture.string(
                  // Icon awesome-shield-alt
                  '<svg viewBox="195.61 790.0 25.71 27.42" ><path transform="translate(194.48, 790.0)" d="M 25.25341606140137 4.483322143554688 L 14.97005081176758 0.1985866725444794 C 14.33741283416748 -0.06385793536901474 13.62635803222656 -0.06385793536901474 12.99371814727783 0.1985868513584137 L 2.710351467132568 4.483322143554688 C 1.75164258480072 4.879660129547119 1.125 5.816946029663086 1.125 6.85599422454834 C 1.125 17.48749351501465 7.257527828216553 24.83581352233887 12.98836135864258 27.22455596923828 C 13.62035942077637 27.48699760437012 14.33269596099854 27.48699760437012 14.96469593048096 27.22455596923828 C 19.55471801757813 25.31249046325684 26.83341217041016 18.70864295959473 26.83341217041016 6.85599422454834 C 26.83341217041016 5.816946029663086 26.20677185058594 4.879660129547119 25.25341606140137 4.483322143554688 Z M 13.98456192016602 23.90388488769531 L 13.97920608520508 3.497832536697388 L 23.4002685546875 7.423721313476563 C 23.22352409362793 15.53258323669434 19.00305938720703 21.40802574157715 13.98456287384033 23.90388488769531 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 25.71,
                  height: 27.42,
                ),
                Spacer(flex: 69),
                SvgPicture.string(
                  // Icon feather-settings
                  '<svg viewBox="1.5 1.5 25.42 25.42" ><path transform="translate(-2.76, -2.76)" d="M 20.43310546875 16.966552734375 C 20.43310546875 18.88107681274414 18.88107681274414 20.43310546875 16.966552734375 20.43310546875 C 15.05202865600586 20.43310546875 13.5 18.88107681274414 13.5 16.966552734375 C 13.5 15.05202865600586 15.05202865600586 13.5 16.966552734375 13.5 C 18.88107681274414 13.5 20.43310546875 15.05202865600586 20.43310546875 16.966552734375 Z" fill="none" stroke="#ffffff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path transform="translate(0.0, 0.0)" d="M 22.76152229309082 17.67724609375 C 22.44682121276855 18.39030265808105 22.59782600402832 19.22311401367188 23.14284324645996 19.78028869628906 L 23.2121753692627 19.84961891174316 C 23.6461353302002 20.2830982208252 23.88997077941895 20.87130737304688 23.88997077941895 21.48467636108398 C 23.88997077941895 22.09804534912109 23.6461353302002 22.68625640869141 23.21217727661133 23.1197338104248 C 22.77870178222656 23.55369186401367 22.19049072265625 23.79752731323242 21.57711982727051 23.79752731323242 C 20.96375274658203 23.79752731323242 20.37554168701172 23.55369186401367 19.94206428527832 23.1197338104248 L 19.87273025512695 23.05040168762207 C 19.3155574798584 22.5053825378418 18.48274803161621 22.35437774658203 17.76969146728516 22.6690788269043 C 17.07121658325195 22.96843910217285 16.6172046661377 23.65399360656738 16.61417198181152 24.41390991210938 L 16.61417198181152 24.6103515625 C 16.61417198181152 25.88669967651367 15.57948589324951 26.92138671875 14.30313682556152 26.92138671875 C 13.02678680419922 26.92138671875 11.99210166931152 25.88669967651367 11.99210166931152 24.6103515625 L 11.99210166931152 24.5063533782959 C 11.97379398345947 23.72368812561035 11.47890186309814 23.03175926208496 10.744140625 22.76152420043945 C 10.03108310699463 22.44682121276855 9.198273658752441 22.59782600402832 8.641098976135254 23.14284515380859 L 8.571767807006836 23.2121753692627 C 8.138291358947754 23.6461353302002 7.5500807762146 23.88997077941895 6.936710834503174 23.88997077941895 C 6.323340892791748 23.88997077941895 5.735130310058594 23.6461353302002 5.301653861999512 23.2121753692627 C 4.867694854736328 22.77869987487793 4.62385892868042 22.19049072265625 4.62385892868042 21.57711982727051 C 4.62385892868042 20.9637508392334 4.867694854736328 20.37554168701172 5.301653385162354 19.94206428527832 L 5.370984077453613 19.87273025512695 C 5.916001319885254 19.3155574798584 6.067005634307861 18.48274803161621 5.752305030822754 17.76969146728516 C 5.452947616577148 17.07121467590332 4.767391681671143 16.6172046661377 4.007473468780518 16.61417388916016 L 3.81103515625 16.61417198181152 C 2.534685611724854 16.61417198181152 1.5 15.57948589324951 1.5 14.30313682556152 C 1.5 13.02678680419922 2.534686088562012 11.99210166931152 3.811035394668579 11.99210166931152 L 3.915031909942627 11.99210166931152 C 4.697698593139648 11.97379493713379 5.389628887176514 11.47890281677246 5.659863471984863 10.744140625 C 5.974564552307129 10.03108215332031 5.823560237884521 9.198273658752441 5.278542041778564 8.641098976135254 L 5.209211349487305 8.571767807006836 C 4.775252819061279 8.138291358947754 4.531415939331055 7.550081253051758 4.531415939331055 6.936711311340332 C 4.531415939331055 6.32334041595459 4.775252342224121 5.735129833221436 5.209211826324463 5.301652908325195 C 5.642688751220703 4.867693901062012 6.230899333953857 4.623857498168945 6.844269275665283 4.623857975006104 C 7.457638263702393 4.623857975006104 8.045848846435547 4.867693901062012 8.479325294494629 5.301653385162354 L 8.548656463623047 5.370984077453613 C 9.105832099914551 5.91600227355957 9.938640594482422 6.067005634307861 10.65169811248779 5.752305030822754 L 10.744140625 5.752305030822754 C 11.44261741638184 5.45294713973999 11.89662742614746 4.767391204833984 11.899658203125 4.007473468780518 L 11.899658203125 3.81103515625 C 11.899658203125 2.534685611724854 12.9343433380127 1.499999642372131 14.210693359375 1.5 C 15.48704242706299 1.5 16.521728515625 2.534685611724854 16.521728515625 3.81103515625 L 16.521728515625 3.915031909942627 C 16.52475929260254 4.67495059967041 16.9787712097168 5.360506057739258 17.67724800109863 5.659863948822021 C 18.39030456542969 5.974564552307129 19.22311401367188 5.823561191558838 19.78028869628906 5.278542995452881 L 19.84961891174316 5.209211826324463 C 20.2830982208252 4.775253295898438 20.87130737304688 4.531417369842529 21.48467636108398 4.531417369842529 C 22.09804534912109 4.531417369842529 22.68625640869141 4.775253295898438 23.11973190307617 5.209211826324463 C 23.55369186401367 5.642689228057861 23.79752731323242 6.230899333953857 23.79752731323242 6.844269275665283 C 23.79752731323242 7.457639217376709 23.55369186401367 8.045848846435547 23.11973190307617 8.479326248168945 L 23.05040168762207 8.548657417297363 C 22.5053825378418 9.105832099914551 22.35437774658203 9.938640594482422 22.6690788269043 10.65170001983643 L 22.6690788269043 10.744140625 C 22.96843910217285 11.44261741638184 23.65399360656738 11.89662647247314 24.41390991210938 11.899658203125 L 24.6103515625 11.899658203125 C 25.88669967651367 11.899658203125 26.92138671875 12.9343433380127 26.92138671875 14.210693359375 C 26.92138671875 15.48704242706299 25.88669967651367 16.521728515625 24.6103515625 16.521728515625 L 24.5063533782959 16.521728515625 C 23.74643898010254 16.52476119995117 23.06088256835938 16.9787712097168 22.76152610778809 17.67724800109863 Z" fill="none" stroke="#ffffff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                  width: 25.42,
                  height: 25.42,
                ),
                Spacer(flex: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
