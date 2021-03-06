import 'package:flutter/foundation.dart';

class Player {
  Player(
      {@required this.id,
      @required this.name,
      @required this.email,
      this.preferredCourtLocation = "",
      this.availability = "",
      this.skillLevel = "",
      this.phone = "",
      this.rank = 99});
  String id;
  String name;
  String email;
  String preferredCourtLocation;
  String availability;
  String skillLevel;
  String phone;
  int rank;

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        preferredCourtLocation: json['preferredCourtLocation'],
        availability: json['availability'],
        skillLevel: json['skillLevel'],
        phone: json['phone'],
        rank: json['rank']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      'email': this.email,
      'preferredCourtLocation': this.preferredCourtLocation,
      'availability': this.availability,
      'skillLevel': this.skillLevel,
      'rank': this.rank
    };
  }
}
