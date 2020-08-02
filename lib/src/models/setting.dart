
class Setting {
  String appName = "Travel TDF";
  String mainColor = '#FFFFFF';
  String secondColor = '#3f51b5';
  String accentColor = '#000000';
  String scaffoldColor = '#FFF1F1F1';
  String googleMapsKey = 'AIzaSyBFmqr3-aJp23CM3BZPnPqH4nMh9SlgR1Q';

  Setting();

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    return map;
  }
}
