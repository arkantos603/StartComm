import 'package:get_it/get_it.dart';
import 'package:startcomm/features/sign_in/sign_in_controller.dart';
import 'package:startcomm/features/sign_up/sign_up_controller.dart';
import 'package:startcomm/services/auth_services/auth_services.dart';
import 'package:startcomm/services/mock_auth_service.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerLazySingleton<AuthService>(() => MockAuthService());

  locator.registerFactory<SignInController>(
    () => SignInController(locator.get<AuthService>()));
  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>()));

}
