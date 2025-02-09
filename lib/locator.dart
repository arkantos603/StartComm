import 'package:get_it/get_it.dart';
import 'package:startcomm/features/home/home_controller.dart';
import 'package:startcomm/features/sign_in/sign_in_controller.dart';
import 'package:startcomm/features/sign_up/sign_up_controller.dart';
import 'package:startcomm/features/splash/splash_controller.dart';
import 'package:startcomm/features/caixa/transaction_controller.dart';
import 'package:startcomm/repositories/products_repository.dart';
import 'package:startcomm/repositories/transaction_repository.dart';
import 'package:startcomm/repositories/ingredient_repository.dart';
import 'package:startcomm/services/auth_services.dart';
import 'package:startcomm/services/firebase_auth_services.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'package:startcomm/features/products/products_controller.dart';

final locator = GetIt.instance;

void setupDependencies() {
  // Registrar AuthService como singleton
  locator.registerLazySingleton<AuthService>(
    () => FirebaseAuthService(),
  );

  // Registrar SecureStorage como singleton
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorage(),
  );

  // Registrar SplashController
  locator.registerFactory<SplashController>(
    () => SplashController(locator.get<SecureStorage>()),
  );

  // Registrar SignInController
  locator.registerFactory<SignInController>(
    () => SignInController(
      locator.get<AuthService>(),
      locator.get<SecureStorage>(),
    ),
  );

  // Registrar SignUpController
  locator.registerFactory<SignUpController>(
    () => SignUpController(
      locator.get<AuthService>(),
      locator.get<SecureStorage>(),
    ),
  );

  // Registrar TransactionRepository
  locator.registerFactory<TransactionRepository>(
    () => TransactionRepositoryImpl(),
  );

  // Registrar ProductRepository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepository(),
  );

  // Registrar ProductsController
  locator.registerFactory<ProductsController>(
    () => ProductsController(locator.get<ProductRepository>()),
  );

  // Registrar IngredientRepository
  locator.registerLazySingleton<IngredientRepository>(
    () => IngredientRepository(),
  );

  // Registrar HomeController
  locator.registerLazySingleton<HomeController>(
    () => HomeController(locator.get<TransactionRepository>()),
  );

  // Registrar TransactionController
  locator.registerFactory<TransactionController>(
    () => TransactionController(locator.get<TransactionRepository>()),
  );
}