
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ketodiet/model/dietrecipes_response.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/utils/myspacer.dart';
import 'package:ketodiet/utils/sessionmanager.dart';
import 'package:ketodiet/widgets/myappbar.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipiesScreen extends StatefulWidget {
  const RecipiesScreen({Key? key}) : super(key: key);

  @override
  State<RecipiesScreen> createState() => _RecipiesScreenState();
}

class _RecipiesScreenState extends State<RecipiesScreen> {
  List<String> days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  FoodDataBean? breakFast;
  FoodDataBean? lunch;
  FoodDataBean? dinner;
  FoodDataBean? snacks;

  List<RecipesBean> allDataList = [];
  bool veg = true;
  var day;
  int weekday = 1;


  @override
  void initState() {
    getCurrentWeek();
    getFoodPref();
    getRecipesData();
    super.initState();
  }
  getCurrentWeek(){
    setState(() {
      DateTime now = DateTime.now();
      weekday = now.weekday;
      print('current week:>>>$weekday');
    });
  }

  getFoodPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      veg = prefs.getBool('vegetarian')!;
      print('vegeterian>>>>>$veg');
    });
  }

  Future<void> getRecipesData() async {
    SessionManager manager = SessionManager();
    DietrecipesResponse? getRecipesList = await manager.getDietRecipesResponse();
    if (getRecipesList!.recipes!.isNotEmpty) {
      setState(() {
        day = DateFormat(DateFormat.WEEKDAY).format(DateTime.now());
      });
     print('length>>>>${getRecipesList.recipes![0].Veg!.Breakfast!.length} >>>>>$day');
     print('day>>>>${getRecipesList.recipes![0].Veg!.Breakfast![2].Day} >>>>>$day');

     for(int i=0;i<getRecipesList.recipes![0].Veg!.Breakfast!.length;i++){
       if(day == getRecipesList.recipes![0].Veg!.Breakfast![i].Day && veg == true){
         breakFast = getRecipesList.recipes![0].Veg!.Breakfast![i];
         lunch = getRecipesList.recipes![0].Veg!.Lunch![i];
         dinner = getRecipesList.recipes![0].Veg!.Dinner![i];
         snacks = getRecipesList.recipes![0].Veg!.Snacks![i];
         print('breakFast>>veg>>${breakFast!.Title}>>${dinner!.Title}');
       }else if(day == getRecipesList.recipes![0].NonVeg!.Breakfast![i].Day){
         breakFast = getRecipesList.recipes![0].NonVeg!.Breakfast![i];
         lunch = getRecipesList.recipes![0].NonVeg!.Lunch![i];
         dinner = getRecipesList.recipes![0].NonVeg!.Dinner![i];
         snacks = getRecipesList.recipes![0].NonVeg!.Snacks![i];
         print('breakFast>>nonveg>>${breakFast!.Title}>>${dinner!.Title}');
       }
     }
    } else {
      print('Null data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: MyAppBar.myAppBar(context,'Recipes',false,(){},(){} ,primaryColor),
      body:
      day == null ?
      const Center(
        child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator()),
      ):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 7.9,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 12,
                      );
                    },
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return MyContainer(
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.height / 6,
                          color: textColor1,
                          border: Border.all(color:Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        child:   Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height:MediaQuery.of(context).size.height / 15,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: MyRegularText(isHeading: true,label:
                                days[index],
                                  fontSize: 15,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            MySpacer.minispacer,
                            weekday == (index+1) ?
                            const Icon(Icons.check_circle,size: 16,color: whiteColor,):
                            const Icon(Icons.check_circle,size: 16,color: textColor1,),
                            MySpacer.minispacer,
                          ],
                        ),
                         );
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  MySpacer.spacer,
                  MyRegularText(isHeading: true,label: '$day Schedules',
                  fontWeight:  FontWeight.w600,
                    fontSize: 20,
                    align: TextAlign.start,
                  ),
                  MySpacer.spacer,
                  MyContainer(
                    width: double.infinity,
                    color: greycontainerColor,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyRegularText(isHeading: true,label: 'BreakFast:',fontSize: 20,fontWeight:  FontWeight.w600,),
                              MySpacer.mediumspacer,
                              MyRegularText(isHeading: false,label: breakFast!.Title!,fontSize: 16,fontWeight: FontWeight.w400,maxlines: 10,align: TextAlign.start,),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Ingredients:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: breakFast!.Ingredients!,fontSize: 15,fontWeight: FontWeight.w300,
                              align: TextAlign.start,
                                maxlines: 30,
                              ),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Instructions:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: breakFast!.Instructions!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  MySpacer.spacer30,
                  MyContainer(
                    width: double.infinity,
                    color: greycontainerColor,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyRegularText(isHeading: true,label: 'Lunch:',fontSize: 20,fontWeight:  FontWeight.w600,),
                              MySpacer.mediumspacer,
                              MyRegularText(isHeading: false,label: lunch!.Title!,fontSize: 16,fontWeight: FontWeight.w400,maxlines: 10,align: TextAlign.start,),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Ingredients:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: lunch!.Ingredients!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Instructions:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: lunch!.Instructions!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  MySpacer.spacer30,
                  MyContainer(
                    width: double.infinity,
                    color: greycontainerColor,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyRegularText(isHeading: true,label: 'Dinner:',fontSize: 20,fontWeight:  FontWeight.w600,),
                              MySpacer.mediumspacer,
                              MyRegularText(isHeading: false,label: dinner!.Title!,fontSize: 16,fontWeight: FontWeight.w400,maxlines: 10,align: TextAlign.start,),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Ingredients:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: dinner!.Ingredients!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Instructions:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: dinner!.Instructions!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  MySpacer.spacer30,
                  MyContainer(
                    width: double.infinity,
                    color: greycontainerColor,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyRegularText(isHeading: true,label: 'Snacks:',fontSize: 20,fontWeight:  FontWeight.w600,),
                              MySpacer.mediumspacer,
                              MyRegularText(isHeading: false,label: snacks!.Title!,fontSize: 16,fontWeight: FontWeight.w400,maxlines: 10,align: TextAlign.start,),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Ingredients:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: snacks!.Ingredients!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                              MySpacer.minispacer,
                              const MyRegularText(isHeading: true,label: 'Instructions:',fontSize: 18,fontWeight:  FontWeight.w600,),
                              MySpacer.minispacer,
                              MyRegularText(isHeading: false,label: snacks!.Instructions!,fontSize: 15,fontWeight: FontWeight.w300,
                                align: TextAlign.start,
                                maxlines: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 9,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
