class CurrentWeather {
  //Current time, Unix, UTC
  int dt;

  //Sunrise and Sunrise time, Unix, UTC
  int sunrise, sunset;

  // Temperature. Units - default: kelvin, metric: Celsius, imperial
  double temp;
  double feelsLike;
  int pressure;
  int humidity;

  // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  double dewPoint;

  // Cloudiness, %
  int clouds;

  // Current UV index
  int uvi;

  //Average visibility, metres
  int visibility;

  //Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
  int windSpeed;

  //Wind direction, degrees (meteorological)
  int windDeg;

  CurrentWeather(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.clouds,
      this.uvi,
      this.visibility,
      this.windSpeed,
      this.windDeg});
}
/**
 *
 * current: {
    dt: 1614149509,
    sunrise: 1614171014,
    sunset: 1614211724,
    temp: 289.1,
    feels_like: 283.29,
    pressure: 1014,
    humidity: 42,
    dew_point: 276.21,
    uvi: 0,
    clouds: 1,
    visibility: 10000,
    wind_speed: 6.17,
    wind_deg: 190,
    weather: [
    {
    id: 800,
    main: "Clear",
    description: "clear sky",
    icon: "01n"
    }
    ]
    },
 *
 *
 *
 *
 *
 **/
