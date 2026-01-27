import 'package:gongbab/domain/entities/kiosk_status.dart';
import 'package:gongbab/domain/repositories/kiosk_repository.dart';
import 'package:injectable/injectable.dart'; // injectable 임포트

@injectable // 등록
class GetKioskStatusUseCase {
  final KioskRepository repository;

  GetKioskStatusUseCase(this.repository);

  Future<KioskStatus> call() {
    return repository.getKioskStatus();
  }
}
