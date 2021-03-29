import 'package:e_commerce/modules/dashboard/cubit/cubit.dart';
import 'package:e_commerce/modules/login/cubit/cubit.dart';
import 'package:e_commerce/modules/signup/cubit/cubit.dart';
import 'package:e_commerce/shared/app_cubit/cubit.dart';
import 'package:e_commerce/shared/network/local/cash_helper.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:e_commerce/shared/network/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImplementation(
      di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImplementation(),
  );
  di.registerLazySingleton<Repository>(
        () => RepoImplementation(
      dioHelper: di<DioHelper>(),
      cacheHelper:di<CacheHelper>(),
    ),
  );
  di.registerFactory<AppCubit>(
    () => AppCubit(),
  );
  di.registerFactory<SignUpScreenCubit>(
        () => SignUpScreenCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<LoginScreenCubit>(
    () => LoginScreenCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<DashboardCubit>(
        () => DashboardCubit(
      di<Repository>(),
    ),
  );
}
