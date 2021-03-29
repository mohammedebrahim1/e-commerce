import 'dart:convert';

import 'package:e_commerce/models/categories/categories_model.dart';
import 'package:e_commerce/models/home_data/home_data.dart';
import 'package:e_commerce/modules/dashboard/cubit/states.dart';
import 'package:e_commerce/shared/commponents/constants.dart';
import 'package:e_commerce/shared/network/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  final Repository repository;

  DashboardCubit(this.repository) : super(DashboardInitialState());

  static DashboardCubit get(context) => BlocProvider.of(context);
  HomeDataModel homeDataModel;
  CategoriesModel categoriesModel;

  getHomeData() {
    emit(DashboardDataLoadingState());
    repository.getHomeData(token: userToken).then((value) {
      print(jsonDecode(value.toString()));
      homeDataModel = HomeDataModel.fromJson(value.data);
      if (homeDataModel.status) {
        print(homeDataModel.data.banners[0].id);
        emit(DashboardDataSuccessState());
      } else {
        emit(DashboardDataErrorState(error: homeDataModel.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(DashboardDataErrorState(error: error.toString()));
    });

    // DioHelper.getData(path: HOME_END_POINT ,token: getToken() )
    //     .then((value) {
    //   // print(jsonDecode(value.toString()));
    //   // if(jsonDecode(value.toString())['status'] == false)
    //   // {
    //   //   showToast(text:  jsonDecode(value.toString())['message'] ,  isError: true);
    //   //   emit(DashboardDataErrorState());
    //   //   return;
    //   // }
    //   homeDataModel = HomeDataModel.fromJson(value.data);
    //   print(homeDataModel.data.banners[0].id);
    //   emit(DashboardDataSuccessState());
    //
    //
    // })
    //     .catchError((error){
    //   print(error.toString());
    //   showToast(text: error.toString() ,  isError: true);
    //   emit(DashboardDataErrorState(error: error.toString()));
    // });
  }
  getCategories()
  {
    emit(DashboardCategoriesLoadingState());
    repository.getCategories().then((value) {
      print(jsonDecode(value.toString()));
      categoriesModel = CategoriesModel.fromJson(value.data);
      if(categoriesModel.status)
        emit(DashboardCategoriesSuccessState());
      else
        emit(DashboardCategoriesErrorState(error: categoriesModel.message));


    }).catchError((error){
      print(error.toString());
      emit(DashboardCategoriesErrorState(error: error.toString()));
    });


  }
}
