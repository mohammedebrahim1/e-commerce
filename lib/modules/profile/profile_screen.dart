import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/network/local/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kPrimaryColor,
                  width: getProportionateScreenWidth(3.0),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: getProportionateScreenWidth(50.0),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Allie Grater',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(28.0),
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(6.5),
                    ),
                    Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                      size: getProportionateScreenWidth(16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(19.0),
                ),
                Text(
                  'alliegrater@gmail.com',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14.0),
                  ),
                ),
                Container(
                  width: double.infinity,
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(25.0),
            ),
            Row(
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}
