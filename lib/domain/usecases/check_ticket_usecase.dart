import 'package:gongbab/domain/repositories/kiosk_repository.dart';
import 'package:injectable/injectable.dart'; // injectable 임포트

@injectable // 등록
class CheckTicketUseCase {
  final KioskRepository repository;

  CheckTicketUseCase(this.repository);

  Future<void> call(String ticketId) {
    return repository.checkTicket(ticketId);
  }
}
