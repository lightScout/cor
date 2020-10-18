import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 22,
          ),
          Text(
            'Settings',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontFamily: 'PressStart2P'),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About Cor',
                    style: TextStyle(
                        fontFamily: 'PressStart2P',
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ValueListenableBuilder(
                    valueListenable: Hive.box('settings').listenable(),
                    builder: (context, box, widget) {
                      return ListTile(
                        leading: Switch(
                          activeColor: Colors.deepOrange,
                          inactiveTrackColor: Colors.grey,
                          value: box.get('accuracyMode', defaultValue: false),
                          onChanged: (val) => box.put('accuracyMode', val),
                        ),
                        title: Text(
                          '100% Accuracy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}

// LiteRollingSwitch(
// //initial value
// animationDuration: Duration(milliseconds: 200),
// value: a,
// textOn: 'ON',
// textOff: 'OFF',
// colorOn: Colors.greenAccent[700],
// colorOff: Colors.redAccent[700],
// iconOn: Icons.done,
// iconOff: Icons.remove_circle_outline,
// textSize: 16.0,
// onChanged: (bool state) {
// //Use it to manage the different states
//
// print('Current State of SWITCH IS: $state');
// },
// onTap: () {
// _setAccuracySate();
// },
// ),
