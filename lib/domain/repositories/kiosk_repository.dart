import 'package:gongbab/domain/entities/kiosk_status.dart';

abstract class KioskRepository {
  Future<KioskStatus> getKioskStatus();
  Future<void> checkTicket(String ticketId); // 식권 체크인 후 반환값이 없을 수 있으므로 void로 가정
}
