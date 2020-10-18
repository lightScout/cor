import 'package:cor/data/color_repository.dart';
import 'package:cor/pages/color_pick_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'cubit/cor_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final settingsBox = await Hive.openBox(
    'settings',
    compactionStrategy: (int total, int deleted) {
      return deleted > 0;
    },
  );
  runApp(ValueListenableBuilder(
      valueListenable: settingsBox.listenable(),
      builder: (context, box, widget) => MyApp()));
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }
}
