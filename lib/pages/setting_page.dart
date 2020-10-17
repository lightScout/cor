import 'package:cor/model/user_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserPreferenceModel>(
      builder: (context, pref, child) {
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
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'PressStart2P'),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About Cor',
                    style: TextStyle(
                        fontFamily: 'PressStart2P',
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        leading: LiteRollingSwitch(
                          //initial value
                          animationDuration: Duration(milliseconds: 200),
                          value: pref.getAccuracyMode,
                          textOn: 'ON',
                          textOff: 'OFF',
                          colorOn: Colors.greenAccent[700],
                          colorOff: Colors.redAccent[700],
                          iconOn: Icons.done,
                          iconOff: Icons.remove_circle_outline,
                          textSize: 16.0,
                          onChanged: (bool state) {
                            //Use it to manage the different states

                            print('Current State of SWITCH IS: $state');
                          },
                          onTap: () {
                            Provider.of<UserPreferenceModel>(context,
                                    listen: false)
                                .setAccuracyMode();
                          },
                        ),
                        title: Text(
                          '100% Accuracy',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PoiretOne'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
