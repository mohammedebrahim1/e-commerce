import 'package:e_commerce/shared/di/di.dart';
import 'package:e_commerce/shared/network/local/cash_helper.dart';
import 'package:flutter/services.dart';

// AppLanguageModel appLang(context) => AppCubit.get(context).languageModel;

String appLanguage = '';

String userToken = '';

Future<String> getAppLanguage() async {
  return await di<CacheHelper>().get('appLang');
}

Future<String> getUserToken() async {
  return await di<CacheHelper>().get('userToken');
}

Future<bool> setAppLanguageToShared(String code) async {
  appLanguage = code;
  return await di<CacheHelper>().put('appLang', code);
}

Future<String> getTranslationFile(String appLanguage) async {
  return await rootBundle
      .loadString('assets/translation/${appLanguage ?? 'en'}.json');
}
