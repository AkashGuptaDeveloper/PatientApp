class TimeAvailabilityModel {
  int status;
  String msg;
  List<TimeAvailabilityList> availability;

  TimeAvailabilityModel({this.status, this.msg, this.availability});

  TimeAvailabilityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['availability'] != null) {
      availability = new List<TimeAvailabilityList>();
      json['availability'].forEach((v) {
        availability.add(new TimeAvailabilityList.fromJson(v));
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

class TimeAvailabilityList {
  String time;
  String available;

  TimeAvailabilityList({this.time, this.available});

  TimeAvailabilityList.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['available'] = this.available;
    return data;
  }
}