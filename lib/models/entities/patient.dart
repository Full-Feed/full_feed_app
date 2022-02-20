
import 'package:full_feed_app/models/entities/user.dart';

class Patient {
  final int? patientId;
  final double? arm;
  final double? tmb;
  final double? height;
  final double? weight;
  final double? imc;
  final double? abdominal;
  final User? user;

  Patient({this.patientId, this.arm, this.tmb, this.height, this.weight, this.imc, this.abdominal, this.user});

  factory Patient.fromJson(dynamic json) {

    Map<String, dynamic> patientJson = json;
    return Patient(
      patientId: patientJson['patientId'],
      arm: patientJson['arm'],
      tmb: patientJson['tmb'],
      height: patientJson['height'],
      weight: patientJson['weight'],
      imc: patientJson['imc'],
      abdominal: patientJson['abdominal'],
      user: User.fromJson(patientJson['user']),
    );
  }
}

class UserLoginDto {
  final String email;
  final String password;

  UserLoginDto(this.email, this.password);
}