import 'dart:math' as math;

import 'package:cor/model/color.dart';
import 'package:flutter/material.dart';

abstract class ColorRepository {
  /// Throws [NetworkException].
  Future<Cor> fetchColor();
}

class FakeColorRepository implements ColorRepository {
  @override
  Future<Cor> fetchColor() {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        Color _color = Color(0xFFFFFFFF);
        math.Random _random = math.Random();
        _color = Color.fromARGB(
          //or with fromRGBO with fourth arg as _random.nextDouble(),
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
        );

        //Simulate some network exception
        if (_random.nextBool()) {
          throw NetworkException();
        }

        // Return "fetched" Color
        return Cor(
          // Random Color
          cor: _color,
          description: '$_color',
        );
      },
    );
  }
}

class NetworkException implements Exception {}
