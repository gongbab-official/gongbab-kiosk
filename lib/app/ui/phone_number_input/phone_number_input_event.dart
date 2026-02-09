import 'package:gongbab/domain/entities/lookup/employee_match.dart';

// UI Event
sealed class PhoneNumberInputEvent {}

class ScreenInitialized extends PhoneNumberInputEvent {}

class PhoneNumberEntered extends PhoneNumberInputEvent {
  final String phoneNumber;

  PhoneNumberEntered(this.phoneNumber);
}

class EmployeeSelected extends PhoneNumberInputEvent {
  final EmployeeMatch employee;

  EmployeeSelected(this.employee);
}
