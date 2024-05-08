import 'package:flutter/material.dart';
import 'package:happypetpaw/HomeScreen.dart';
import 'package:happypetpaw/constants/ConstantColors.dart';
import 'package:happypetpaw/constants/ConstantWidgets.dart';
import 'package:happypetpaw/constants/Constants.dart';
import 'package:happypetpaw/constants/SizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../generated/l10n.dart';

class RateProduct extends StatefulWidget {
  @override
  _RateProduct createState() => _RateProduct();
}

class _RateProduct extends State<RateProduct> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockVertical !* 100;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantColors.bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantColors.bgColor,
            title: getCustomText(S.of(context).rateReview, textColor, 1,
                TextAlign.center, FontWeight.bold, 17),
              leading: InkWell(
                onTap: () {
                  finish();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey,
                ),
              )
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal !* 5),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.safeBlockVertical! * 23,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal !* 4,
                      vertical: SizeConfig.safeBlockVertical !* 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(
                        Constants.assetsImagePath + "dog_cloths.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                getCustomText(
                    S.of(context).rateTheFood,
                    textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    Constants.getPercentSize(totalHeight, 2)),
                getSpace(Constants.getPercentSize(totalHeight, 2)),
                Center(
                  child: RatingBar.builder(
                    itemSize: SizeConfig.safeBlockVertical !* 4,
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal !* 2),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: SizeConfig.safeBlockVertical! * 4,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                getSpace(Constants.getPercentSize(totalHeight, 2)),
                getCustomText(
                    S.of(context).shareYourOpinion,
                    textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    Constants.getPercentSize(totalHeight, 2)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey, width: 2),
                      color: "#F4F7FC".toColor()),
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal !* 4,
                      vertical: SizeConfig.safeBlockVertical !* 3),
                  width: double.infinity,
                  height: Constants.getPercentSize(totalHeight, 17),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).yourReview,
                        hintStyle: TextStyle(
                            fontSize: Constants.getPercentSize(totalHeight, 2),
                            fontFamily: Constants.fontsFamily,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    style: TextStyle(
                        fontSize: Constants.getPercentSize(totalHeight, 2),
                        fontFamily: Constants.fontsFamily,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal! * 4),
                  child: getButtonWithColorWithSize(
                      S.of(context).submit,
                      accentColors,
                      Constants.getPercentSize1(totalHeight, 1.6),
                      Constants.getPercentSize1(totalHeight, 2),
                      () {
                        // LaunchReview.launch(writeReview: true);
                      }),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  void finish() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(0),));
  }
}
