import 'package:gongbab/domain/entities/employee_lookup_entity.dart';
import 'package:gongbab/domain/repositories/kiosk_repository.dart';
import 'package:gongbab/domain/utils/result.dart';

class GetEmployeeCandidatesUseCase {
  final KioskRepository repository;

  GetEmployeeCandidatesUseCase(this.repository);

  Future<Result<EmployeeLookupEntity>> execute({
    required int restaurantId,
    required String phoneLastFour,
  }) {
    return repository.getEmployeeCandidates(
      restaurantId: restaurantId,
      phoneLastFour: phoneLastFour,
    );
  }
}