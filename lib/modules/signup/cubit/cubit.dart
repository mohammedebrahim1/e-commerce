import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/modules/login/login_screen.dart';
import 'package:e_commerce/modules/signup/cubit/states.dart';
import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/network/remote/end_points.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:e_commerce/shared/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreenCubit extends Cubit<SignUpScreenStates> {
  final Repository repository;

  SignUpScreenCubit(this.repository) : super(SignUpScreenInitialState());

  static SignUpScreenCubit get(context) => BlocProvider.of(context);
  List errors = [];
  BuildContext context;

  File image;

  Future<void> pickImage() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        emit(SignUpScreenPickImageState());

        print(value.path);
      }
    });
  }

  void addEmailNullError() {
    errors.add(kEmailNullError);
    emit(SignUpScreenAddEmailErrorState());
  }

  void addFNameNullError() {
    errors.add(kFNameNullError);
    emit(SignUpScreenAddFNameErrorState());
  }

  void addLNameNullError() {
    errors.add(kPhoneNullError);
    emit(SignUpScreenAddLNameErrorState());
  }

  void addPassWordNullError() {
    errors.add(kPassNullError);
    emit(SignUpScreenAddPasswordErrorState());
  }

  void addEmailNotValidError() {
    errors.add(kInvalidEmailError);
    emit(SignUpScreenAddEmailErrorState());
  }

  void addPasswordShortError() {
    errors.add(kShortPassError);
    emit(SignUpScreenAddPasswordErrorState());
  }

  void removeEmailNullError() {
    errors.remove(kEmailNullError);
    emit(SignUpScreenRemoveEmailErrorState());
  }

  void removeFNameNullError() {
    errors.remove(kFNameNullError);
    emit(SignUpScreenRemoveFNameErrorState());
  }

  void removeLNameNullError() {
    errors.remove(kPhoneNullError);
    emit(SignUpScreenRemoveLNameErrorState());
  }

  void removePassWordNullError() {
    errors.remove(kPassNullError);
    emit(SignUpScreenRemovePasswordErrorState());
  }

  void removeEmailNotValidError() {
    errors.remove(kInvalidEmailError);
    emit(SignUpScreenRemoveEmailErrorState());
  }

  void removePasswordShortError() {
    errors.remove(kShortPassError);
    emit(SignUpScreenRemovePasswordErrorState());
  }

  register({
    String email,
    String password,
    String fullName,
    String phone,
  }) {
    emit(SignUpScreenLoadingState());
    repository
        .register(
            email: email, password: password, fullName: fullName, phone: phone)
        .then((value) {
      print(jsonDecode(value.toString())['message']);
      if (jsonDecode(value.toString())['status']) {
        emit(SignUpScreenSuccessState());
      } else {
        emit(SignUpScreenErrorState(
            error: jsonDecode(value.toString())['message']));
      }
    }).catchError((error) {
      print(error.toString());

      emit(SignUpScreenErrorState(error: error.toString()));
    });

    // DioHelper.postData(
    //   path: SIGN_UP_END_POINT,
    //   data: {
    //     'name': fullName,
    //     'phone': phone,
    //     'email':email,
    //     'password': password,
    //     'image': 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    //   },
    // ).then((value)
    // {
    //   print(jsonDecode(value.toString())['message']);
    //   navigateAndFinish(route: LoginScreen() , context: context);
    //   emit(SignUpScreenSuccessState());
    // }).catchError((error)
    // {
    //   print(error.toString());
    //   showToast(text: error.toString() , isError: true);
    //
    //   emit(SignUpScreenErrorState(error: error.toString()));
    // });
  }
}
