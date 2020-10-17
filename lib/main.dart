import 'package:cor/data/color_repository.dart';
import 'package:cor/model/user_preference_model.dart';
import 'package:cor/pages/color_pick_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/cor_cubit.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserPreferenceModel(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CorCubit(FakeColorRepository()),
        child: ColorPickPage(),
      ),
    );
  }
}
