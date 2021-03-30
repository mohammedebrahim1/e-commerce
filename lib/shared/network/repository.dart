import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/shared/commponents/constants.dart';
import 'package:e_commerce/shared/network/errors.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:e_commerce/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';

import 'local/cash_helper.dart';

abstract class Repository {
  Future<Response> userLogin({
    @required String email,
    @required String password,
  });

  Future<Response> register({
    @required String email,
    @required String password,
    @required String fullName,
    @required String phone,
  });

  Future<Response> getHomeData({
    @required String token,
  });

  Future<Response> getCategories();

  Future<Response> addOrRemoveFavorite({
    @required int productId,
  });

  Future<Response> addOrRemoveFromCart({
    @required int productId,
  });

// Future<Either<String, UserModel>> userLogin({
//   @required String email,
//   @required String password,
// });
//
// Future<Either<String, List<BlogsModel>>> getAllBlog({
//   @required String token,
// });
//
// Future<Either<String, BlogsModel>> getSingleBlog({
//   @required String token,
//   @required String id,
// });
}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    @required this.dioHelper,
    @required this.cacheHelper,
  });

  @override
  Future<Response> userLogin({
    String email,
    String password,
  }) async {
    return await dioHelper.postData(
      path: LOGIN_END_POINT,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  @override
  Future<Response> getHomeData({
    String token,
  }) async {
    return await dioHelper.getData(
      path: HOME_END_POINT,
      token: token,
    );
  }

  @override
  Future<Response> register(
      {String email, String password, String fullName, String phone}) async {
    return await dioHelper.postData(path: SIGN_UP_END_POINT, data: {
      'name': fullName,
      'phone': phone,
      'email': email,
      'password': password,
      'image':
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    });
  }

  @override
  Future<Response> getCategories() async {
    return await dioHelper.getData(path: CATEGORIES_END_POINT);
  }

  @override
  Future<Response> addOrRemoveFavorite({int productId}) async {
    return await dioHelper.postData(
        path: FAVORITE_END_POINT,
        data: {
          'product_id': productId,
        },
        token: userToken);
  }

  @override
  Future<Response> addOrRemoveFromCart({int productId}) async {
    return await dioHelper.postData(
      path: CART_END_POINT,
      data: {
        'product_id': productId,
      },
      token: userToken,
    );
  }

// @override
// Future<Either<String, List<BlogsModel>>> getAllBlog({
//   @required String token,
// }) async {
//   return _basicErrorHandling<List<BlogsModel>>(
//     onSuccess: () async {
//       final f = await dioHelper.getData(
//         url: ALL_BLOG,
//         token: token,
//       );
//
//       List<BlogsModel> list = [];
//
//       f.forEach((v)
//       {
//         list.add(BlogsModel.fromJson(v));
//       });
//
//       return list;
//     },
//     onServerError: (exception) async
//     {
//       final f = exception.error;
//       final msg = _handleErrorMessages(f['message']);
//       return msg;
//     },
//   );
// }
//
// @override
// Future<Either<String, BlogsModel>> getSingleBlog({
//   @required String token,
//   @required String id,
// }) async {
//   return _basicErrorHandling<BlogsModel>(
//     onSuccess: () async
//     {
//       final f = await dioHelper.getData(
//         url: '$SINGLE_BLOG$id',
//         token: token,
//       );
//
//       return BlogsModel.fromJson(f);
//     },
//     onServerError: (exception) async
//     {
//       final f = exception.error;
//       final msg = _handleErrorMessages(f['message']);
//       return msg;
//     },
//   );
// }
//
// @override
// Future<Either<String, UserModel>> userLogin({
//   @required String email,
//   @required String password,
// }) async {
//   return _basicErrorHandling<UserModel>(
//     onSuccess: () async {
//       final f = await dioHelper.postData(
//         url: LOGIN,
//         data: {
//           'email':email,
//           'password':password,
//         },
//       );
//       return UserModel.fromJson(f);
//     },
//     onServerError: (exception) async
//     {
//       final f = exception.error;
//       final msg = _handleErrorMessages(f['message']);
//       return msg;
//     },
//   );
// }
}

extension on Repository {
  String _handleErrorMessages(final dynamic f) {
    String msg = '';
    if (f is String) {
      msg = f;
    } else if (f is Map) {
      for (dynamic l in f.values) {
        if (l is List) {
          for (final s in l) {
            msg += '$s\n';
          }
        }
      }
      if (msg.contains('\n')) {
        msg = msg.substring(0, msg.lastIndexOf('\n'));
      }
      if (msg.isEmpty) {
        msg = 'Server Error';
      }
    } else {
      msg = 'Server Error';
    }
    return msg;
  }

  Future<Either<String, T>> _basicErrorHandling<T>({
    @required Future<T> onSuccess(),
    Future<String> onServerError(ServerException exception),
    Future<String> onCacheError(CacheException exception),
    Future<String> onOtherError(Exception exception),
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e, s) {
      print(s);
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return Left('Server Error');
    } on CacheException catch (e, s) {
//      print(e);
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return Left('Cache Error');
    } catch (e, s) {
      print(s);
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}
