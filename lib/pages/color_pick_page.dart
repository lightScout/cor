import 'dart:collection';

import 'package:cor/cubit/cor_cubit.dart';
import 'package:cor/data/color_data.dart';
import 'package:cor/model/color.dart';
import 'package:cor/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColorPickPage extends StatefulWidget {
  @override
  _ColorPickPageState createState() => _ColorPickPageState();
}

class _ColorPickPageState extends State<ColorPickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Color Search",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.2),
            child: GestureDetector(
              child: Icon(Icons.settings),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                        child: SettingsPage(),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                      )),
                  backgroundColor: Colors.transparent,
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<CorCubit, CorState>(
          listener: (context, state) {
            if (state is CorError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CorInitial) {
              return buildInitialInput();
            } else if (state is CorLoading) {
              return buildLoading();
            } else if (state is CorLoaded) {
              return buildColumnWithData(state.map);
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput() {
    return ColorInputButton();
  }

  Widget buildColumnWithData(HashMap color) {
    String colorHex = '0xFFF${color['color']}';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Color(int.parse(colorHex)),
              // border: Border.all(
              //   color: Colors.red[500],
              // ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: 300,
          height: 400,
          child: Center(
            child: Text(
              '${color['name']}',
              style: TextStyle(
                fontSize: 33,
              ),
            ),
          ),
        ),
        // Text(
        //   cor.description,
        //   style: TextStyle(
        //     fontSize: 11,
        //     color: Colors.white,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // Text(
        //   // Display the temperature with 1 decimal place
        //   "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
        //   style: TextStyle(fontSize: 80),
        // ),
        ColorInputButton(),
      ],
    );
  }
}

class ColorInputButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, box, widget) {
          return MaterialButton(
            color: Colors.redAccent,
            onPressed: () {
              fetchColor(context, box.get('accuracyMode', defaultValue: false));
              print(box.get('accuracyMode', defaultValue: false));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.deepOrange)),
          );
        });
  }
}

void fetchColor(BuildContext context, bool accuracy) {
  final corCubit = context.bloc<CorCubit>();
  corCubit.getCor(accuracy);
}
