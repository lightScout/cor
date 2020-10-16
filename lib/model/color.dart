import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Cor extends Equatable {
  final Color cor;
  final String description;

  Cor({
    @required this.cor,
    @required this.description,
  });

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
