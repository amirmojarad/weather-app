class City {
  String city, country, id;
  double lat, lon;

  City({this.city, this.country, this.id, this.lat, this.lon});

  City.fromDB({
    this.city,
    this.country,
    this.id,
    this.lat,
    this.lon,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      "city": this.city,
      "country": this.country,
      "id": this.id,
      "lat": this.lat,
      "lon": this.lon
    };
  }

  @override
  String toString() {
    return 'City{city: $city, country: $country}';
  }
}

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
      country: json["country"],
      lat: json["lat"],
      id: json["id"],
      city: json["city"],
      lon: json["lon"]);
}
