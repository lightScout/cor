import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const colorAPIURL = 'https://www.thecolorapi.com/id?hex=';

class ColorData {
  Future<Map> getColorData() async {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();

    Color _color = Color(0xFFFFFFFF);
    math.Random _random = math.Random();
    _color = Color.fromARGB(
      //or with fromRGBO with fourth arg as _random.nextDouble(),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
    var _colorHexFormat = '${_color.value.toRadixString(16).padLeft(6, '0')}';
    _colorHexFormat = _colorHexFormat.substring(2);

    String requestURL = '$colorAPIURL$_colorHexFormat';
    http.Response response = await http.get(
      requestURL,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var colorValueFromAPI = decodedData['hex']['clean'];
      var colorNameFromAPI = decodedData['name']['value'];
      print(decodedData['hex']);
      map['color'] = colorValueFromAPI;
      map['name'] =
          colorNameFromAPI; // here can use better names for the map ID
      //print(map);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }

    return map;
  }
}
