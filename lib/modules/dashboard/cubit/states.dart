abstract class DashboardStates{}
class DashboardInitialState extends DashboardStates{}
class DashboardDataSuccessState extends DashboardStates{}
class DashboardDataLoadingState extends DashboardStates{}
class DashboardDataErrorState extends DashboardStates{
  String error;

  DashboardDataErrorState({this.error});
}
class DashboardCategoriesSuccessState extends DashboardStates{}
class DashboardCategoriesLoadingState extends DashboardStates{}
class DashboardCategoriesErrorState extends DashboardStates {
  String error;

  DashboardCategoriesErrorState({this.error});
}
class DashboardAddOrRemoveFavoriteLoadingState extends DashboardStates{}
class DashboardAddOrRemoveFavoriteSuccessState extends DashboardStates{}
class DashboardAddOrRemoveFavoriteErrorState extends DashboardStates {
  String error;

  DashboardAddOrRemoveFavoriteErrorState({this.error});
}
class DashboardAddOrRemoveFromCartLoadingState extends DashboardStates{}
class DashboardAddOrRemoveFromCartSuccessState extends DashboardStates{}
class DashboardAddOrRemoveFromCartErrorState extends DashboardStates {
  String error;

  DashboardAddOrRemoveFromCartErrorState({this.error});
}
class DashboardChangeCartLocalState extends DashboardStates{}


