class City {
  String city, country, id;
  double lat, lon;

  City.fromDB({
    this.city,
    this.country,
    this.id,
    this.lat,
    this.lon,
  });
}
