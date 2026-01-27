import 'package:equatable/equatable.dart';

class KioskStatus extends Equatable {
  final String status;
  final String message;
  final String location;
  final DateTime lastUpdated;

  const KioskStatus({
    required this.status,
    required this.message,
    required this.location,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [status, message, location, lastUpdated];
}
