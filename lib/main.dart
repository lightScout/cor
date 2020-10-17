import 'package:cor/data/color_repository.dart';
import 'package:cor/model/user_preference_model.dart';
import 'package:cor/pages/color_pick_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'cubit/cor_cubit.dart';
import 'model/user_preference.dart';

void main() async {
  // Hive initialisation
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserPreferenceAdapter());
  final userPreferenceBox = await Hive.openBox(
    'userPreference',
    compactionStrategy: (int total, int deleted) {
      return deleted > 0;
    },
  );

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
