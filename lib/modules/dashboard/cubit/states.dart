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
class DashboardAddOrRemoveFavoriteSuccessState extends DashboardStates{}
class DashboardAddOrRemoveFavoriteErrorState extends DashboardStates {
  String error;

  DashboardAddOrRemoveFavoriteErrorState({this.error});
}
class DashboardAssignFavoriteSuccessState extends DashboardStates{}
class DashboardChangeFavoriteSuccessState extends DashboardStates{}


