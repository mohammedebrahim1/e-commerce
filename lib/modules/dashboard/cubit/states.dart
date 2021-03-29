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
