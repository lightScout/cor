import 'package:cor/data/color_repository.dart';
import 'package:cor/pages/color_pick_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cor_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => CorCubit(FakeColorRepository()),
          child: ColorPickPage()),
    );
  }
}
