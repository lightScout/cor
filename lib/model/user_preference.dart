import 'package:hive/hive.dart';

part 'user_preference.g.dart';

@HiveType(typeId: 1)
class UserPreference {
  @HiveField(0)
  String preferenceName;

  @HiveField(1)
  bool state;

  UserPreference({this.preferenceName, this.state});

  bool toggleState() {
    state = !state;
    bool result = state;
    return result;
  }
}
