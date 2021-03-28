import 'package:flutter/foundation.dart';

class Player {
  Player(
      {@required id,
      @required this.name,
      @required this.email,
      this.preferredCourtLocation = "",
      this.availability = "",
      this.skillLevel = "",
      this.phone = ""});
  String id;
  String name;
  String email;
  String preferredCourtLocation;
  String availability;
  String skillLevel;
  String phone;

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        preferredCourtLocation: json['preferredCourtLocation'],
        availability: json['availability'],
        skillLevel: json['skillLevel'],
        phone: json['phone']);
  }
}
