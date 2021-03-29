import 'dart:convert';

import 'package:e_commerce/models/user/user_model.dart';
import 'package:e_commerce/modules/login/cubit/states.dart';
import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates>
{
  final Repository repository;
  UserModel userModel;

  LoginScreenCubit(this.repository) : super(LoginScreenInitialState());
  static LoginScreenCubit get (context) => BlocProvider.of(context);
  List errors = [];
  bool remember = false ;
  BuildContext context ;
  void addEmailNullError()
  {
    errors.add(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }
  void addPassWordNullError()
  {
    errors.add(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void addEmailNotValidError()
  {
    errors.add(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }
  void addPasswordShortError()
  {
    errors.add(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void removeEmailNullError()
  {
    errors.remove(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }
  void removePassWordNullError()
  {
    errors.remove(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void removeEmailNotValidError()
  {
    errors.remove(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }
  void removePasswordShortError()
  {
    errors.remove(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void changeCheck(value)
  {
    remember = value ;
    emit(LoginScreenRememberState());
  }
  login({
    String username,
    String password,
  }) {
    emit(LoginScreenLoadingState());
    repository.userLogin(email: username, password: password).then((value) {
        print(jsonDecode(value.toString()));
        userModel = UserModel.fromJson(value.data);

        if(userModel.status)
        {
          emit(LoginScreenSuccessState(userModel));
        } else
        {
          emit(LoginScreenErrorState(error:userModel.message));
        }
    }).catchError((error){
        print(error.toString());
        showToast(text: error.toString() ,  isError: true);
        emit(LoginScreenErrorState(error: error.toString()));

    });

    // DioHelper.postData(
    //   path: LOGIN_END_POINT,
    //   data: {
    //     'email': username,
    //     'password': password,
    //   },
    // ).then((value)
    // {
    //   print(jsonDecode(value.toString()));
    //   if(jsonDecode(value.toString())['status'] == false)
    //   {
    //     showToast(text:  jsonDecode(value.toString())['message'] ,  isError: true);
    //     emit(LoginScreenErrorState());
    //     return;
    // }
    //   String token = jsonDecode(value.toString())['token'] as String;
    //
    //   saveToken(token).then((value) {
    //     print('success => ');
    //   }).catchError((error){
    //     print('error => ${error.toString()}');
    //   });
    //
    //   navigateAndFinish(context: context , route: HomeScreen());
    //
    //   emit(LoginScreenSuccessState());
    // }).catchError((error)
    // {
    //   print(error.toString());
    //   showToast(text: error.toString() ,  isError: true);
    //   emit(LoginScreenErrorState(error: error.toString()));
    // });
  }

}