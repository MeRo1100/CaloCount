import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketodiet/model/diet_response.dart';
import 'package:ketodiet/model/hive/userdata/userdatamodel.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/utils/myspacer.dart';
import 'package:ketodiet/utils/sessionmanager.dart';
import 'package:ketodiet/widgets/bottom_sheet.dart';
import 'package:ketodiet/widgets/myappbar.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemScreen extends StatefulWidget {
  String? name;
  UserDataModel? userdata;

  String? time;
  AddItemScreen({this.name, this.userdata, this.time, Key? key})
      : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<FoodsBean> itemsList = [];
  List<DataBean> vegList = [];
  List<DataBean> nonVegList = [];
  int? selectedIndex = -1;
  DateTime? dateTime;
  bool veg = true;

  @override
  void initState() {
    dateTime = DateTime.now();
    print('time is here::::${widget.time}');
    getFoodPref();
    getDietData();
    super.initState();
  }

  Future<void> getDietData() async {
    SessionManager manager = SessionManager();
    DietResponse? getDietList = await manager.getDietResponse();
    setState(() {
      if (getDietList!.foods!.isNotEmpty) {
        itemsList = getDietList.foods!;
        if (itemsList.isNotEmpty) {
          vegList = itemsList[0].veg!;
          nonVegList = itemsList[0].nonveg!;
          print(
              'itemsList>>>>${itemsList.length}  vegList>>>>${vegList.length}  nonvegList>>>>${nonVegList.length}');
        }
      } else {
        print('Null data');
      }
    });
  }

  getFoodPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      veg = prefs.getBool('vegetarian') ?? true;
      print('vegeterian>>>>>$veg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: MyAppBar.myAppBar(context, 'Search', true, () {
        Navigator.pop(context);
      }, () {}, primaryColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: MyContainer(
              borderRadius: BorderRadius.circular(8),
              height: 40,
              color: lightColor,
              child: TextField(
                expands: false,
                onChanged: (value) {},
                style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'lexendDeca',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          MySpacer.spacer,
          vegList.isEmpty || nonVegList.isEmpty
              ? const Center(
                  child: SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator()))
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return MySpacer.spacer;
                    },
                    padding: EdgeInsets.zero,
                    itemCount: veg ? vegList.length : nonVegList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          if (selectedIndex == index) {
                            bottomSheet(index);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: MyContainer(
                            color: greycontainerColor,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: MyContainer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15.5,
                                            color: greyColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  veg
                                                      ? vegList[index].image!
                                                      : nonVegList[index]
                                                          .image!,
                                                  // itemsList[index].image!,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                        MySpacer.width10,
                                        Flexible(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              MyRegularText(
                                                isHeading: true,
                                                label: veg
                                                    ? vegList[index].name!
                                                    : nonVegList[index].name!,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.5,
                                                maxlines: 10,
                                                align: TextAlign.start,
                                              ),
                                              MySpacer.minispacer,
                                              MyRegularText(
                                                isHeading: false,
                                                label: veg
                                                    ? vegList[index]
                                                        .servingSize!
                                                    : nonVegList[index]
                                                        .servingSize!,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.grey,
                                                align: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MySpacer.width2,
                                  Flexible(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const MyRegularText(
                                                isHeading: false,
                                                label: 'Calories',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                align: TextAlign.start,
                                                color: Colors.grey,
                                              ),
                                              MyRegularText(
                                                isHeading: false,
                                                label: veg
                                                    ? vegList[index]
                                                        .calories
                                                        .toString()
                                                    : nonVegList[index]
                                                        .calories
                                                        .toString(),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.grey,
                                                align: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          MySpacer.width6,
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: greyColor,
                                            size: 16,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  bottomSheet(index) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(25),
            topStart: Radius.circular(25),
          ),
        ),
        builder: (context) => MyBottomSheet(
            foodData: veg ? vegList[index] : nonVegList[index],
            name: widget.name,
            userdata: widget.userdata,
            time: widget.time));
  }
}
