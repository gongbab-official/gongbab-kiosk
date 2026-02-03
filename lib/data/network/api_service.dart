import 'package:gongbab/data/models/common_model.dart';
import 'package:gongbab/data/models/kiosk_status_model.dart';
import 'package:gongbab/data/network/app_api_client.dart';
import 'package:gongbab/data/network/rest_api_client.dart';
import 'package:gongbab/domain/utils/result.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiService {
  final AppApiClient _appApiClient;

  ApiService(this._appApiClient);

  Future<Result<KioskStatusModel>> getKioskStatus(int restaurantId) async {
    return _appApiClient.request(
      method: RestMethod.get,
      path: '/api/v1/restaurants/$restaurantId/kiosks/heartbeat',
      fromJson: KioskStatusModel.fromJson,
    );
  }

  Future<Result<CommonModel>> checkTicket(String ticketId) async {
    return _appApiClient.request(
      method: RestMethod.post,
      path: '/ticket/checkin',
      data: {'ticketId': ticketId},
      fromJson: CommonModel.fromJson,
    );
  }
}