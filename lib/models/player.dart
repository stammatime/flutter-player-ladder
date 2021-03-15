import 'package:flutter/foundation.dart';

class Player {
  Player(
      {@required this.name,
      @required this.email,
      this.preferredCourtLocation = "",
      this.availability = "",
      this.skillLevel = "",
      this.phone = ""});
  String name;
  String email;
  String preferredCourtLocation;
  String availability;
  String skillLevel;
  String phone;
}
