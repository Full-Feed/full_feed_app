
class PatientRegisterDto {
  final String username;
  final String firstName;
  final String lastName;
  final String dni;
  final String email;
  final String password;
  final String rol;
  final String sex;
  final String birthDate;
  final String phone;
  final int regionId;
  final double abdominal;
  final double arm;
  final double imc;
  final double tmb;
  final double height;
  final double weight;

  PatientRegisterDto(this.username, this.firstName, this.lastName, this.dni, this.email, this.password, this.rol, this.sex,
      this.birthDate, this.phone, this.regionId, this.abdominal, this.arm, this.imc, this.tmb, this.height, this.weight);
}