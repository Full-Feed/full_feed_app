import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/preference.dart';
import 'package:full_feed_app/utilities/connection_tags.dart';

class PreferenceProvider with ChangeNotifier {

  final connectionTags = ConnectionTags();

  Future<List<Preference>> listAllPreferences() async{

    final api = connectionTags.baseUrl + connectionTags.preferencesEndpoint;

    final dio = Dio();
    Response response;
    response = await dio.get(api);
    if(response.statusCode == 200){
      var data = response.data["data"] as List;
      var preferenceList = data.map((e) => Preference.fromJson(e)).toList();
      return preferenceList;
    }
    return [];
  }

}