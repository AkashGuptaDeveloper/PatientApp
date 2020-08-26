class CheckAvilityModel {
  int status;
  String msg;
  List<Availability> availability;

  CheckAvilityModel({this.status, this.msg, this.availability});

  CheckAvilityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['availability'] != null) {
      availability = new List<Availability>();
      json['availability'].forEach((v) {
        availability.add(new Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.availability != null) {
      data['availability'] = this.availability.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Availability {
  String date;
  int availablity;
  DateTime dateTime;

  Availability({this.date, this.availablity, this.dateTime});

  Availability.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    availablity = json['availablity'];
    /*dateTime = DateTime.tryParse(json['date_time']);*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['availablity'] = this.availablity;
    if (this.dateTime != null) {
      data['date_time'] = this.dateTime.toJson();
    }
    return data;
  }
}

class DateTime {
  String s1000;
  String s1020;
  String s1040;
  String s1100;
  String s1120;
  String s1140;
  String s1200;
  String s1220;
  String s1240;
  String s0900;
  String s0920;
  String s0940;
  String s0100;
  String s0120;
  String s0140;
  String s0200;
  String s0220;
  String s0240;
  String s0300;
  String s0320;
  String s0340;
  String s0400;
  String s0420;
  String s0440;
  String s0500;
  String s0520;
  String s0540;
  String s0600;
  String s0620;
  String s0640;

  DateTime(
      {this.s1000,
        this.s1020,
        this.s1040,
        this.s1100,
        this.s1120,
        this.s1140,
        this.s1200,
        this.s1220,
        this.s1240,
        this.s0900,
        this.s0920,
        this.s0940,
        this.s0100,
        this.s0120,
        this.s0140,
        this.s0200,
        this.s0220,
        this.s0240,
        this.s0300,
        this.s0320,
        this.s0340,
        this.s0400,
        this.s0420,
        this.s0440,
        this.s0500,
        this.s0520,
        this.s0540,
        this.s0600,
        this.s0620,
        this.s0640});

  DateTime.fromJson(Map<String, dynamic> json) {
    s1000 = json['1000'];
    s1020 = json['1020'];
    s1040 = json['1040'];
    s1100 = json['1100'];
    s1120 = json['1120'];
    s1140 = json['1140'];
    s1200 = json['1200'];
    s1220 = json['1220'];
    s1240 = json['1240'];
    s0900 = json['0900'];
    s0920 = json['0920'];
    s0940 = json['0940'];
    s0100 = json['0100'];
    s0120 = json['0120'];
    s0140 = json['0140'];
    s0200 = json['0200'];
    s0220 = json['0220'];
    s0240 = json['0240'];
    s0300 = json['0300'];
    s0320 = json['0320'];
    s0340 = json['0340'];
    s0400 = json['0400'];
    s0420 = json['0420'];
    s0440 = json['0440'];
    s0500 = json['0500'];
    s0520 = json['0520'];
    s0540 = json['0540'];
    s0600 = json['0600'];
    s0620 = json['0620'];
    s0640 = json['0640'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1000'] = this.s1000;
    data['1020'] = this.s1020;
    data['1040'] = this.s1040;
    data['1100'] = this.s1100;
    data['1120'] = this.s1120;
    data['1140'] = this.s1140;
    data['1200'] = this.s1200;
    data['1220'] = this.s1220;
    data['1240'] = this.s1240;
    data['0900'] = this.s0900;
    data['0920'] = this.s0920;
    data['0940'] = this.s0940;
    data['0100'] = this.s0100;
    data['0120'] = this.s0120;
    data['0140'] = this.s0140;
    data['0200'] = this.s0200;
    data['0220'] = this.s0220;
    data['0240'] = this.s0240;
    data['0300'] = this.s0300;
    data['0320'] = this.s0320;
    data['0340'] = this.s0340;
    data['0400'] = this.s0400;
    data['0420'] = this.s0420;
    data['0440'] = this.s0440;
    data['0500'] = this.s0500;
    data['0520'] = this.s0520;
    data['0540'] = this.s0540;
    data['0600'] = this.s0600;
    data['0620'] = this.s0620;
    data['0640'] = this.s0640;
    return data;
  }
}