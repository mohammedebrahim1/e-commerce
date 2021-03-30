import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce/models/categories/categories_model.dart';
import 'package:e_commerce/models/home_data/home_data.dart';
import 'package:e_commerce/modules/dashboard/cubit/cubit.dart';
import 'package:e_commerce/modules/dashboard/cubit/states.dart';
import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/network/local/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
    {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
    {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/Discover.svg", "text": "More"},
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (BuildContext context, state) {
        if (state is DashboardDataErrorState) {
          showToast(text: state.error, isError: true);
        }
      },
      builder: (BuildContext context, state) {
        HomeDataModel homeDataModel = DashboardCubit.get(context).homeDataModel;
        CategoriesModel categoriesModel =
            DashboardCubit.get(context).categoriesModel;
        return Scaffold(
          backgroundColor: kScaffoldColor,
          body: ConditionalBuilder(
            fallback: (ctx) => SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.6,
                            height: getProportionateScreenHeight(50.0),
                            decoration: BoxDecoration(
                              color: kSecondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              onChanged: (value) => print(value),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20),
                                      vertical: getProportionateScreenWidth(9)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Search product",
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          appBarIconButton(
                            numOfItem: DashboardCubit.get(context).cartProductsNumber >= 9 ? '+9' : DashboardCubit.get(context).cartProductsNumber.toString(),
                            icon: "assets/icons/Cart Icon.svg",
                          ),
                          appBarIconButton(
                            numOfItem: 3,
                            icon: "assets/icons/Bell.svg",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(15),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF4A3298),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(text: "A Summer Surpise\n"),
                            TextSpan(
                              text: "Cashback 20%",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          categories.length,
                          (index) => categoryCard(
                            icon: categories[index]["icon"],
                            text: categories[index]["text"],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(20)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                  categoriesModel.data.data.length,
                                  (index) => specialOfferCard(
                                      category:
                                          categoriesModel.data.data[index])),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Text(
                            'Popular Products',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(20)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                homeDataModel.data.products.length,
                                (index) {
                                  return productCard(
                                      product:
                                          homeDataModel.data.products[index],
                                      function_fav: () {
                                        DashboardCubit.get(context)
                                            .addOrRemoveFavorite(
                                                homeDataModel
                                                    .data.products[index].id,
                                                index);
                                      },
                                      inFavorites: homeDataModel
                                          .data.products[index].inFavorites,
                                      inCart: homeDataModel
                                          .data.products[index].inCart,
                                      function_cart: () {
                                        DashboardCubit.get(context)
                                            .addOrRemoveFromCart(
                                                homeDataModel
                                                    .data.products[index].id,
                                                index);
                                      });
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                  ],
                ),
              ),
            ),
            builder: (ctx) => Center(child: CircularProgressIndicator()),
            condition: state is DashboardDataLoadingState ||
                state is DashboardCategoriesLoadingState,
          ),
        );
      },
    );
  }
}
