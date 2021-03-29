class AppLanguageModel {
  String body1;
  String body2;
  String body3;
  String loginTitle;
  String loginSubTitle;
  String email;
  String password;
  String login;
  String registerNow;
  String emailValidation;
  String passwordValidation;
  String home;
  String favourites;
  String cart;
  String settings;
  String search;

  AppLanguageModel({
    this.body1,
    this.body2,
    this.body3,
    this.loginTitle,
    this.loginSubTitle,
    this.email,
    this.password,
    this.login,
    this.registerNow,
    this.emailValidation,
    this.passwordValidation,
    this.home,
    this.cart,
    this.settings,
    this.favourites,
    this.search,
  });

  AppLanguageModel.fromJson(Map<String, dynamic> json) {
    body1 = json['body1'];
    body2 = json['body2'];
    body3 = json['body3'];
    loginTitle = json['loginTitle'];
    loginSubTitle = json['loginSubTitle'];
    email = json['email'];
    password = json['password'];
    login = json['login'];
    registerNow = json['registerNow'];
    emailValidation = json['emailValidation'];
    passwordValidation = json['passwordValidation'];
    home = json['home'];
    cart = json['cart'];
    settings = json['settings'];
    search = json['search'];
  }
}
