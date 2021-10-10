import 'package:http/http.dart';
import 'dart:convert'; //이건기본으로있음

class Network{
  final String url;

  Network(this.url);

  Future<dynamic> getJsonData() async{
    Response response = await get(Uri.parse(url));
    if(response.statusCode ==200){
      String jsonData = response.body.toString();
      var parsingJson = jsonDecode(jsonData);
      return parsingJson;
    }else{
      print(response.body);
    }
  }

  // Future<dynamic> getAirData() async{
  //   Response response = await get(Uri.parse(urlAir));
  //   if(response.statusCode ==200){
  //     String jsonData = response.body.toString();
  //     var parsingJson = jsonDecode(jsonData);
  //     return parsingJson;
  //   }else{
  //     print(response.body);
  //   }
  // }
}