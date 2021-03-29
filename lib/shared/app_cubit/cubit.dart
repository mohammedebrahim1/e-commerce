import 'package:e_commerce/shared/app_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(AppCubitInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
}
