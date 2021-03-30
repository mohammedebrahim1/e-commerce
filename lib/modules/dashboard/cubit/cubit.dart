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
  int cartProductsNumber = 0;

  void initCartNumber()
  {
    emit(DashboardDataLoadingState());
    homeDataModel.data.products.forEach((element) {
      if(element.inCart)
        cartProductsNumber++;
    });
    emit(DashboardChangeCartLocalState());
  }
  getHomeData() {
    emit(DashboardDataLoadingState());
    repository.getHomeData(token: userToken).then((value) {
      print(jsonDecode(value.toString()));
      homeDataModel = HomeDataModel.fromJson(value.data);
      if (homeDataModel.status) {
        print(homeDataModel.data.banners[0].id);
        initCartNumber();
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

  getCategories() {
    emit(DashboardCategoriesLoadingState());
    repository.getCategories().then((value) {
      print(jsonDecode(value.toString()));
      categoriesModel = CategoriesModel.fromJson(value.data);
      if (categoriesModel.status)
        emit(DashboardCategoriesSuccessState());
      else
        emit(DashboardCategoriesErrorState(error: categoriesModel.message));
    }).catchError((error) {
      print(error.toString());
      emit(DashboardCategoriesErrorState(error: error.toString()));
    });
  }

  addOrRemoveFavorite(int productId, int index) {
    changeFavoriteLocal(index);
    emit(DashboardAddOrRemoveFavoriteLoadingState());
    repository.addOrRemoveFavorite(productId: productId).then((value) {
      print(jsonDecode(value.toString()));
      // print(value.data['status'].toString());
      // print(jsonDecode(value.data['status']).toString());
      if ((value.data['status']) == false) {
        changeFavoriteLocal(index);
      }
      emit(DashboardAddOrRemoveFavoriteSuccessState());
    }).catchError((error) {
      changeFavoriteLocal(index);
      print(error.toString());
      emit(DashboardAddOrRemoveFavoriteErrorState(error: error.toString()));
    });
  }

  changeFavoriteLocal(int index) {
    homeDataModel.data.products[index].inFavorites =
        !homeDataModel.data.products[index].inFavorites;
  }
  addOrRemoveFromCart(int productId, int index) {
    changeCartLocal(index);
    emit(DashboardAddOrRemoveFromCartLoadingState());
    repository.addOrRemoveFromCart(productId: productId).then((value) {
      print(jsonDecode(value.toString()));
      // print(value.data['status'].toString());
      // print(jsonDecode(value.data['status']).toString());
      if ((value.data['status']) == false) {
        changeCartLocal(index);
      }
      emit(DashboardAddOrRemoveFromCartSuccessState());
    }).catchError((error) {
      changeCartLocal(index);
      print(error.toString());
      emit(DashboardAddOrRemoveFromCartErrorState(error: error.toString()));
    });
  }

  changeCartLocal(int index) {
    homeDataModel.data.products[index].inCart =
    !homeDataModel.data.products[index].inCart;
    if( homeDataModel.data.products[index].inCart)
    {
      cartProductsNumber++;
    } else
    {
      cartProductsNumber--;
    }
    emit(DashboardChangeCartLocalState());
  }
}
