import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:happypetpaw/constants/ConstantColors.dart';
import 'package:happypetpaw/constants/ConstantWidgets.dart';
import 'package:happypetpaw/constants/Constants.dart';
import 'package:happypetpaw/constants/SizeConfig.dart';
import 'package:happypetpaw/data/DataFile.dart';
import 'package:happypetpaw/generated/l10n.dart';
import 'package:happypetpaw/model/ModelCoupon.dart';

class CouponList extends StatefulWidget {
  @override
  _CouponList createState() => _CouponList();
}

class _CouponList extends State<CouponList> {
  List<ModelCoupon> _couponList = DataFile.getAllCouponList();
  int selectedPos = 0;
  // int selectedPos = -1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double itemHeight = SizeConfig.safeBlockVertical! * 10;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: getCustomText(S.of(context).applyCoupon, textColor, 1,
                TextAlign.start, FontWeight.w600, 18),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: textColor,
                  ),
                  onPressed: () {
                    finish("");
                  },
                );
              },
            )),
        backgroundColor: ConstantColors.bgColor,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 4),
                child: getCustomText(S.of(context).availableCoupon, textColor,
                    1, TextAlign.start, FontWeight.w600, 18),
              ),
              getSpace(SizeConfig.safeBlockVertical! * 3),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _couponList.length,
                    itemBuilder: (context, index) {
                      ModelCoupon _coupon = _couponList[index];
                      return Container(
                          width: double.infinity,
                          height: itemHeight,
                          margin: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal! * 4),
                          child: DottedBorder(
                            strokeWidth: 1.5,
                            color: Colors.grey,
                            dashPattern: [8, 4],
                            strokeCap: StrokeCap.round,
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: getCustomText(
                                            _coupon.title,
                                            textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w700,
                                            Constants.getPercentSize(
                                                itemHeight, 22)),
                                        flex: 1,
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: (selectedPos == index)
                                                  ? Colors.green
                                                  : "#778898".toColor(),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7))),
                                          child: getCustomText(
                                              _coupon.couponCode,
                                              Colors.white,
                                              1,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              Constants.getPercentSize(
                                                  itemHeight, 18)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  2,
                                              vertical: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.2),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedPos = index;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  getCustomText(
                                      _coupon.description,
                                      Colors.grey,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      Constants.getPercentSize(itemHeight, 16))
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                flex: 1,
              ),
              Container(
                width: double.infinity,
                height: SizeConfig.safeBlockVertical! * 7,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 8,
                    vertical: SizeConfig.safeBlockHorizontal! * 4),
                child: getButtonWithColorWithSize(
                    S.of(context).applyCoupon,
                    accentColors,
                    Constants.getPercentSize(
                        SizeConfig.safeBlockVertical! * 7, 2),
                    Constants.getPercentSize(
                        SizeConfig.safeBlockVertical! * 7, 30), () {
                  if (selectedPos >= 0) {
                    finish(_couponList[selectedPos].couponCode);
                  }
                }),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        finish("");
        return false;
      },
    );
  }

  void finish(String val) {
    Navigator.of(context).pop(val);
  }
}
