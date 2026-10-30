import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning/core/staticfile.dart';
import 'package:learning/model/news.dart' show news;

class Apicall {
  Future<news?> getnewsdata() async {
    try {
      var url = Uri.https(Staticfile.baseUrl, Staticfile.path, {
        'q': 'bitcoin',
        'sortBy': 'publishedAt',
        'apiKey': Staticfile.apikey,
      });

      var response = await http.get(url);

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        var jsonresponse = convert.jsonDecode(response.body);

        var newsdata = news.fromJson(jsonresponse);

        return newsdata;
      } else {
        if (kDebugMode) {
          print('API Error: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
