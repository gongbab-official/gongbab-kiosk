import 'package:gongbab/domain/entities/check_in/kiosk_check_in.dart';
import 'package:gongbab/domain/entities/lookup/employee_match.dart';
import 'package:gongbab/domain/entities/status/kiosk_status.dart';

// UI State
sealed class PhoneNumberInputUiState {}

class Initial extends PhoneNumberInputUiState {}

class Loading extends PhoneNumberInputUiState {}

class KioskStatusLoaded extends PhoneNumberInputUiState {
  final KioskStatus kioskStatus;
  final bool isWifiConnected;

  KioskStatusLoaded(this.kioskStatus, this.isWifiConnected);
}

class EmployeeCandidatesLoaded extends PhoneNumberInputUiState {
  final List<EmployeeMatch> employees;

  EmployeeCandidatesLoaded(this.employees);
}

class CheckInSuccess extends PhoneNumberInputUiState {
  final KioskCheckIn checkInResult;

  CheckInSuccess(this.checkInResult);
}

class AlreadyLogged extends PhoneNumberInputUiState {
  final String message;

  AlreadyLogged(this.message);
}

class Error extends PhoneNumberInputUiState {
  final String message;

  Error(this.message);
}
