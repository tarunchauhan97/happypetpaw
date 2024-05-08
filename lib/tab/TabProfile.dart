import 'package:flutter/material.dart';
import 'package:happypetpaw/constants/ConstantColors.dart';
import 'package:happypetpaw/constants/ConstantWidgets.dart';
import 'package:happypetpaw/constants/Constants.dart';
import 'package:happypetpaw/constants/SizeConfig.dart';
import 'package:happypetpaw/data/DataFile.dart';
import 'package:happypetpaw/data/PrefData.dart';
import 'package:happypetpaw/generated/l10n.dart';
import 'package:happypetpaw/main.dart';
import 'package:happypetpaw/model/ProfileModel.dart';
import 'package:happypetpaw/screen/AboutUsPage.dart';
import 'package:happypetpaw/screen/EditProfilePage.dart';
import 'package:happypetpaw/screen/LoginPage.dart';
import 'package:happypetpaw/screen/MySavedCardsPage.dart';
import 'package:happypetpaw/screen/NotificationList.dart';
import 'package:happypetpaw/screen/ShippingAddressPage.dart';
import 'package:happypetpaw/screen/WriteReviewPage.dart';
import 'package:happypetpaw/tab/TabOrder.dart';

class TabProfile extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // ProfileWidget(this.onChanged);

  @override
  _TabProfile createState() {
    return _TabProfile();
  }
}

class _TabProfile extends State<TabProfile> {
  ProfileModel profileModel = DataFile.getProfileModel();

  bool _isSwitched = false;
  int posGet = 0;

  _setSwitchData() async {
    posGet = await PrefData().getIsDarkMode();
    setState(() {
      if (posGet == 0) {
        _isSwitched = false;
      } else {
        _isSwitched = true;
      }
      print("setswitchdata==1");
    });
  }

  @override
  void initState() {
    _setSwitchData();

    super.initState();
    profileModel = DataFile.getProfileModel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double imageSize = SizeConfig.safeBlockVertical! * 15;

    return Scaffold(
      backgroundColor: ConstantColors.bgColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ConstantColors.bgColor,
          elevation: 0,
          centerTitle: true,
          title: getCustomText(S.of(context).profile, textColor, 1,
              TextAlign.start, FontWeight.bold, 18)),
      body: Container(
        margin: EdgeInsets.only(
            left: leftMargin,
            right: leftMargin,
            bottom: MediaQuery.of(context).size.width * 0.01),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: imageSize,
                          width: imageSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(Constants.assetsImagePath +
                                  profileModel.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getCustomText(
                                    profileModel.name ?? "",
                                    textColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    18),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: getCustomText(
                                      profileModel.email ?? "",
                                      primaryTextColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      12),
                                )
                              ],
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              child: _getCellSwitch(S.of(context).darkMode, Icons.view_day),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            InkWell(
              child: _getCell(S.of(context).editProfiles, Icons.edit),
              onTap: () {
                sendAction(EditProfilePage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).order, Icons.shopping_bag),
              onTap: () {
                sendAction(TabOrder());
              },
            ),
            // InkWell(
            //   child: _getCell(S.of(context).myFavourite, Icons.favorite),
            //   onTap: () {
            //     sendAction(FavouriteProduct());
            //   },
            // ),
            InkWell(
              child: _getCell(
                  S.of(context).shippingAddress, Icons.local_shipping_outlined),
              onTap: () {
                sendAction(ShippingAddressPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).mySavedCards, Icons.credit_card),
              onTap: () {
                sendAction(MySavedCardsPage());
              },
            ),
            // InkWell(
            //   child: _getCell(S.of(context).giftCard,Icons.card_giftcard),
            //   onTap: () {
            //     sendAction(MyVouchers());
            //   },
            // ),
            InkWell(
              child: _getCell(S.of(context).review, Icons.rate_review),
              onTap: () {
                sendAction(WriteReviewPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).notification, Icons.notifications),
              onTap: () {
                sendAction(NotificationList());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).aboutUs, Icons.info),
              onTap: () {
                sendAction(AboutUsPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).logout, Icons.logout),
              onTap: () {
                PrefData.setIsSignIn(false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendAction(StatefulWidget className) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => className));
  }

  Widget _getCellSwitch(String s, var icon) {
    double cellSize = SizeConfig.safeBlockHorizontal! * 15;

    return Container(
      height: cellSize,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: Constants.getPercentSize1(cellSize, 50),
                  width: Constants.getPercentSize1(cellSize, 50),
                  decoration: new BoxDecoration(
                      color: ConstantColors.profileBgColor,
                      // color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Icon(
                    icon,
                    size: Constants.getPercentSize1(cellSize, 30),
                    color: primaryTextColor,
                  ),
                ),
                getCustomText(s, textColor, 1, TextAlign.start, FontWeight.bold,
                    Constants.getPercentSize1(cellSize, 18)),
                new Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Switch(
                    value: _isSwitched,
                    onChanged: (value) {
                      // Provider.of(context).toggleTheme();

                      // PrefData().setDarkMode(value);
                      setState(() {
                        int setval = 0;
                        if (value == true) {
                          // ThemeNotifier().setDarkMode();
                          setval = 1;
                        } else {
                          setval = 0;
                        }
                        PrefData().setDarkModes(setval);
                        // _isSwitched = value;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyApp()));

                        // ConstantDatas.setThemePosition();
                        // _setSwitchData();
                      });
                    },
                    activeTrackColor: accentColors,
                    activeColor: accentColors,
                  ),
                )
              ],
            ),
            flex: 1,
          ),
          Container(
            margin: EdgeInsets.only(
                top: Constants.getPercentSize1(cellSize, 15),
                bottom: Constants.getPercentSize1(cellSize, 12)),
            height: 1,
            color: viewColor,
          ),
        ],
      ),
    );
  }

  Widget _getCell(String s, var icon) {
    double cellSize = SizeConfig.safeBlockHorizontal! * 15;

    return Container(
      height: cellSize,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: Constants.getPercentSize1(cellSize, 50),
                width: Constants.getPercentSize1(cellSize, 50),
                decoration: new BoxDecoration(
                    color: ConstantColors.profileBgColor,
                    // color: whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Icon(
                  icon,
                  size: Constants.getPercentSize1(cellSize, 30),
                  color: primaryTextColor,
                ),
              ),
              getCustomText(s, textColor, 1, TextAlign.start, FontWeight.bold,
                  Constants.getPercentSize1(cellSize, 18)),
              new Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.navigate_next,
                    color: textColor,
                    size: Constants.getPercentSize1(cellSize, 30),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: Constants.getPercentSize1(cellSize, 15),
                bottom: Constants.getPercentSize1(cellSize, 12)),
            height: 1,
            color: viewColor,
          ),
        ],
      ),
    );
  }
}
