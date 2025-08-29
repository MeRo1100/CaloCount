import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:ketodiet/model/hive/userdata/userdatamodel.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/utils/myspacer.dart';
import 'package:ketodiet/widgets/linearprogress.dart';
import 'package:ketodiet/widgets/myappbar.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final Box userBox;
  List<dynamic> goalList = [];
  bool nonveg = false;
  bool veg = true;
  int calGoal = 0;
  int proteinGoal = 0;
  int carbsGoal = 0;
  int fatGoal = 0;
  bool isCurrentDate = false;
  bool isSlider = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  userBox = Hive.box('userdata');
    print("isOpen  ${userBox.isOpen}:::::::::::${userBox.length}");
    if(userBox.isNotEmpty){
      getGoalData();
    }*/
    getFoodPref();
    getGoal();
  }

  @override
  void dispose() {
    //setGoalData();
    // TODO: implement dispose
    super.dispose();
  }

  setFoodPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('vegetarian', veg);
  }

  getGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      calGoal = prefs.getInt('caloriesGoal')!;
      proteinGoal = prefs.getInt('proteinGoal')!;
      carbsGoal = prefs.getInt('carbsGoal')!;
      fatGoal = prefs.getInt('fatGoal')!;
    });
    print(
        'vegeterian>>>>>$veg >> calGoal$calGoal>>proteinGoal$proteinGoal>>carbsGoal$carbsGoal>>>fatGoal$fatGoal');
  }

  getFoodPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print('vegeterian>>>>>$veg ');
    });
  }

  getGoalData() {
    List newUserData = userBox.values.toList();
    goalList.addAll(newUserData);
    print('goalList:::${goalList[0].timestamp}');
  }

  setGoalData(bool isSlider, String text) {
    UserDataModel userGoal = UserDataModel(
      lunchList: [],
      snacksList: [],
      dinnerList: [],
      breakfastList: [],
      caloriesGoal: calGoal.toString(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    setState(() {
      print(
          "myTimeStamp:::::${DateTime.now().millisecondsSinceEpoch.toString()}");
      if (userBox.isEmpty || isCurrentDate == false) {
        userBox.put(DateTime.now().millisecondsSinceEpoch.toString(), userGoal);
      } else if (userBox.isNotEmpty && isCurrentDate == true) {
        userBox.putAt(((userBox.length) - 1), userGoal);
      }
      print("userGoal length:::::${userBox.length.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: MyAppBar.myAppBar(context, 'Settings', true, () {
        // Navigator.pop(context);
      }, () {}, primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySpacer.spacer30,
              const MyRegularText(
                isHeading: true,
                label: 'Your Food Preference',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              MySpacer.mediumspacer,
              MyContainer(
                color: greycontainerColor,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyRegularText(
                        isHeading: false,
                        label: 'Current Preference',
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    backgroundColor: textColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    // title: Text('Pick a color!'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              veg = true;
                                              nonveg = false;
                                            });
                                            setFoodPref();

                                            Navigator.pop(context);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.0, vertical: 14),
                                            child: MyRegularText(
                                              isHeading: false,
                                              label: 'Vegetarian',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                        const MyContainer(
                                          height: 1,
                                          width: double.infinity,
                                          color: greyColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              veg = false;
                                              nonveg = true;
                                            });
                                            setFoodPref();

                                            Navigator.pop(context);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.0, vertical: 14),
                                            child: MyRegularText(
                                              isHeading: false,
                                              label: 'Non-Vegetarian',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MyContainer(
                            color: textColor1,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6),
                              child: Row(
                                children: [
                                  MyRegularText(
                                    isHeading: false,
                                    label: veg ? 'Veg' : 'Non-Veg',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: whiteColor,
                                  ),
                                  MySpacer.width6,
                                  SvgPicture.asset(
                                    'assets/images/svg/up_down_arrow.svg',
                                    color: whiteColor,
                                    height: 20,
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MySpacer.spacer30,
              const MyRegularText(
                isHeading: true,
                label: 'Your Daily Goal',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              MySpacer.mediumspacer,
              MyContainer(
                color: greycontainerColor,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    children: [
                      LinearProgress(
                        from: 1,
                        text: 'Calories',
                        total: calGoal == 0 ? '0' : calGoal.toString(),
                        subtotal: '799.57',
                        color: redColor,
                        calories: (double caloriesGoal) async {
                          setState(() {
                            calGoal = caloriesGoal.round();
                            print('caloriesGoal>>>>>$calGoal');
                          });
                        },
                        isSlide: (bool value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isSlider = value;
                            prefs.setInt('caloriesGoal', calGoal);
                            isSlider = false;
                          });
                        },
                      ),
                      MySpacer.mediumspacer,
                      const MyContainer(
                        height: 1,
                        width: double.infinity,
                        color: greyColor1,
                      ),
                      MySpacer.mediumspacer,
                      LinearProgress(
                        from: 1,
                        text: 'Protein',
                        total: proteinGoal == 0 ? '0' : proteinGoal.toString(),
                        subtotal: '799.57',
                        color: greenColor,
                        protein: (double proGoal) {
                          setState(() {
                            proteinGoal = proGoal.round();
                            print('proteinGoal>>>>>$proteinGoal');
                          });
                        },
                        isSlide: (bool value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isSlider = value;
                            prefs.setInt('proteinGoal', proteinGoal);
                            isSlider = false;
                          });
                        },
                      ),
                      MySpacer.mediumspacer,
                      const MyContainer(
                        height: 1,
                        width: double.infinity,
                        color: greyColor1,
                      ),
                      MySpacer.mediumspacer,
                      LinearProgress(
                        from: 1,
                        text: 'Carbs',
                        total: carbsGoal == 0 ? '0' : carbsGoal.toString(),
                        subtotal: '799.57',
                        color: blueColor1,
                        carbs: (double carbGoal) {
                          setState(() {
                            carbsGoal = carbGoal.round();
                            print('carbsGoal>>>>>$carbsGoal');
                          });
                        },
                        isSlide: (bool value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isSlider = value;
                            prefs.setInt('carbsGoal', carbsGoal);
                            isSlider = false;
                          });
                        },
                      ),
                      MySpacer.mediumspacer,
                      const MyContainer(
                        height: 1,
                        width: double.infinity,
                        color: greyColor1,
                      ),
                      MySpacer.mediumspacer,
                      LinearProgress(
                        from: 1,
                        text: 'Fat',
                        total: fatGoal == 0 ? '0' : fatGoal.toString(),
                        subtotal: '799.57',
                        color: yellowColor,
                        fat: (double fGoal) {
                          setState(() {
                            fatGoal = fGoal.round();
                            print('fatGoal>>>>>$fatGoal');
                          });
                        },
                        isSlide: (bool value) async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isSlider = value;
                            prefs.setInt('fatGoal', fatGoal);
                            isSlider = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              MyContainer(
                color: greycontainerColor,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    children: [
                      MySpacer.spacer,
                      const MyContainer(
                        height: 1,
                        width: double.infinity,
                        color: greyColor1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
