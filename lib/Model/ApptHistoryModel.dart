class ApptHistoryModel {
  int status;
  String msg;
  int visits;
  String birthday;
  List<History> history;

  ApptHistoryModel(
      {this.status, this.msg, this.visits, this.birthday, this.history});

  ApptHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    visits = json['visits'];
    birthday = json['birthday'];
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['visits'] = this.visits;
    data['birthday'] = this.birthday;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String bookingTime;
  String type;
  Appointment appointment;
  String patientType;
  String status;

  History(
      {this.bookingTime,
        this.type,
        this.appointment,
        this.patientType,
        this.status});

  History.fromJson(Map<String, dynamic> json) {
    bookingTime = json['booking_time'];
    type = json['type'];
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
    patientType = json['patient_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_time'] = this.bookingTime;
    data['type'] = this.type;
    if (this.appointment != null) {
      data['appointment'] = this.appointment.toJson();
    }
    data['patient_type'] = this.patientType;
    data['status'] = this.status;
    return data;
  }
}

class Appointment {
  String appointmentId;
  String date;
  String time;
  String service;

  Appointment({this.appointmentId, this.date, this.time, this.service});

  Appointment.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    date = json['date'];
    time = json['time'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['service'] = this.service;
    return data;
  }
}