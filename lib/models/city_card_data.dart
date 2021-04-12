class CityCardData{
  String name, icon;
  int currentDegree;

  CityCardData(this.name, this.icon, this.currentDegree);

  factory CityCardData.fromJson(Map<String, dynamic> json) => _$CityCardDataFromJson(json);

}
_$CityCardDataFromJson(Map<String, dynamic> json){
  return CityCardData(json["name"], json["icon"], json["currentDegree"]);
}