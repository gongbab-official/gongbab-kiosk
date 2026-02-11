import 'package:mockito/annotations.dart';
import 'package:gongbab/domain/usecases/login_usecase.dart';
import 'package:gongbab/data/auth/auth_token_manager.dart';
import 'package:gongbab/data/device/device_info_service.dart';

@GenerateMocks([LoginUseCase, AuthTokenManager, DeviceInfoService])
// Export the types so they can be used in other test files
export 'package:gongbab/domain/usecases/login_usecase.dart';
export 'package:gongbab/data/auth/auth_token_manager.dart';
export 'package:gongbab/data/device/device_info_service.dart';
