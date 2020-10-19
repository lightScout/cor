import 'dart:collection';
import 'dart:math';

import 'package:cor/cubit/cor_cubit.dart';
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
  bool _isFlipped = false;

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
              return GestureDetector(
                  onTap: () => setState(() => _isFlipped = !_isFlipped),
                  child: buildColumnWithData(state.map, _isFlipped));
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

  Widget buildColumnWithData(HashMap color, bool isFlipped) {
    String colorHex = '0xFFF${color['color']}';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlippableBox(
          isFlipped: isFlipped,
          back: _buildCard(null, color, 400, 300),
          front: _buildCard(colorHex, color, 200, 200),
        ),
        Text(
          '${color['name']}',
          style: TextStyle(fontSize: 22, color: Colors.white),
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

class RotationY extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const RotationY({Key key, @required this.child, this.rotationY = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) //These are magic numbers, just use them :)
          ..rotateY(rotationY * degrees2Radians),
        child: child);
  }
}

class FlippableBox extends StatelessWidget {
  final Container front;
  final Container back;
  final bool isFlipped;

  const FlippableBox({Key key, this.isFlipped = false, this.front, this.back})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 3200),
      curve: Curves.elasticOut,
      tween: Tween(begin: 0.0, end: isFlipped ? 180.0 : 0.0),
      builder: (context, value, child) {
        var content = value >= 90 ? back : front;
        return RotationY(
          rotationY: value,
          child: RotationY(
              rotationY: value >= 90 ? 180 : 0,
              child: AnimatedBackground(child: content)),
        );
      },
    );
  }
}

Widget _buildCard(
    String colorHex, HashMap colorMap, double sizeHeight, double sizeWidth) {
  Color bgColor;
  if (colorHex != null) {
    bgColor = Color(int.parse(colorHex));
  } else {
    bgColor = Colors.white;
  }
  return Container(
    decoration: BoxDecoration(
        color: bgColor,
        // border: Border.all(
        //   color: Colors.red[500],
        // ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    width: sizeWidth,
    height: sizeHeight,
  );
}

class AnimatedBackground extends StatelessWidget {
  final Container child;

  const AnimatedBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: child.constraints.maxWidth,
        height: child.constraints.maxHeight,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeOut,
        child: child);
  }
}
