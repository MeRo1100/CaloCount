import 'dart:math';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ketodiet/model/hive/userdata/userdatamodel.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/utils/constant.dart';
import 'package:ketodiet/utils/myspacer.dart';
import 'package:ketodiet/widgets/daily_stat_ui_model.dart';
import 'package:ketodiet/widgets/dateutils.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';


class CaloriesStatistics extends StatefulWidget {
  const CaloriesStatistics({Key? key}) : super(key: key);

  @override
  State<CaloriesStatistics> createState() => _CaloriesStatisticsState();
}

class _CaloriesStatisticsState extends State<CaloriesStatistics> {
  List<DailyStatUiModel> dailyStatList1 = (List<DailyStatUiModel>.of([]));
  int maxSection1 = -1;
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  String currentWeek = "";
 bool displayNextWeekBtn = false;
  late final Box userBox;
  List<String> selectTime = [];
  List<UserDataModel> userAllList = [];

  @override
  void initState() {
    userBox = Hive.box('userdata');
    setCurrentWeek();
    print(
        "isOpen  ${userBox.isOpen}:::::::::::${userBox.length} ");
    super.initState();
  }
  void setCurrentWeek() async {
    selectedDate = DateTime.now();
    currentWeek = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  String getWeekDisplayDate(DateTime dateTime) {
    return '${AppDateUtils.firstDateOfWeek(dateTime).toFormatString('dd MMM')} - ${AppDateUtils.lastDateOfWeek(dateTime).toFormatString('dd MMM')}';
  }

  List<DailyStatUiModel> getDailyListWithSelectedDay(
      List<DailyStatUiModel> list, int position) {
    return list
        .map((e) => e.copyWith(isSelected: e.dayPosition == position))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      color: whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                 // _previousWeekButton(),
                  _pageIndicatorText(),
                //  _nextWeekButton(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avgcontainer(greenColor,'Avg. protein', Constant.totalCalorie(list: userAllList, item: 'Protein',isAvg: true).toString()),
                      avgcontainer(blueColor1,'Avg. carbs',Constant.totalCalorie(list: userAllList, item: 'Carbs',isAvg: true).toString()),
                      avgcontainer(yellowColor,'Avg. fat',Constant.totalCalorie(list: userAllList, item: 'Fat',isAvg: true).toString()),
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyRegularText(
                      isHeading: false,
                      label: '${Constant.totalCalorie(list: userAllList, item: 'Calories',isAvg: true).toString()} calories',color: greyColor,fontSize: 17,fontWeight: FontWeight.w500,),
                  )
                ],
              ),
            ),
            _buildGraphStat(),
            const MyRegularText(
              isHeading: false,
              label: 'Calories Chart',color: greyColor,fontSize: 14,fontWeight: FontWeight.w500,),
            MySpacer.mediumspacer,
          ],
        ),
    );
  }
  Widget _buildGraphStat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildWeekIndicators(dailyStatList1),
      ],
    );
  }

  Widget avgcontainer(color,String text,String subtext){
    return MyContainer(
      color: color,
      width:MediaQuery.of(context).size.width / 3.8,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyRegularText(
              isHeading: false,
              label: text,fontSize: 13,color: whiteColor,),
            MySpacer.minispacer,
            MyRegularText(
              isHeading: false,
              label: subtext,fontSize: 20,color: whiteColor,),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekIndicators(List<DailyStatUiModel> models) {

    if (models.length == 7) {
      print('.....>>>> print...');
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height /4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDayIndicator(models[0]),
              _buildDayIndicator(models[1]),
              _buildDayIndicator(models[2]),
              _buildDayIndicator(models[3]),
              _buildDayIndicator(models[4]),
              _buildDayIndicator(models[5]),
              _buildDayIndicator(models[6]),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }


  getUserData() async {
    print('ok......');
    for(int i=0;i<selectTime.length;i++){
      if(userBox.containsKey(selectTime[i])){
        dynamic value =  userBox.get(selectTime[i]);
        print('value of box>>>${value.timestamp}');
        userAllList.add(value);
      }
    }
    print('userAllList length is>>>${userAllList.length}');
  }

  Widget _buildDayIndicator(DailyStatUiModel model) {
    return InkWell(
      onTap: () =>
          setSelectedDayPosition(model.dayPosition),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height:  MediaQuery.of(context).size.height /6,
            child: FAProgressBar(
              verticalDirection: VerticalDirection.up,
      size: 12,
      maxValue: 100,
      backgroundColor: Colors.black12,
      progressColor:Colors.blueAccent,
      direction: Axis.vertical,
      currentValue: getStatPercentage(model.stat),
     // currentValue: 20,
      ),
          ),
          const SizedBox(height: 8.0),
          DecoratedBox(
            decoration: _getDayDecoratedBox(model.isToday),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: MyRegularText
                (
                isHeading: false,
                label:
                model.day,
                fontSize: 13,
                color: model.isToday?whiteColor:textColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  _getDayDecoratedBox(bool isToday) {
    if (isToday) {
      return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: textColor,
      );
    } else {
      return const BoxDecoration();
    }
  }

  double getStatPercentage(String time) {
   return getSection1StatPercentage(time);
  }

  double getSection1StatPercentage(String time) {

    print('time>>>>>$time');

    if (userBox.containsKey(time)) {
      return ((Constant.totalCalorie(item: 'Calories',isAvg: false,data:userBox.get(time),list: userAllList ) / 2200)*100).round().toDouble();
    } else {
      return 0;
    }
  }

  Widget _pageIndicatorText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyContainer(
        color: greyColor1,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: MyRegularText(
            isHeading: false,
            label:  currentWeek,
          ),
        ),
      ),
    );
  }

  Widget _previousWeekButton() {
    return GestureDetector(
      onTap: (){
        onPreviousWeek();
      },
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: textColor,
        size: 20,
      ),
    );
  }

  Widget _nextWeekButton() {
    return Visibility(
        visible: displayNextWeekBtn,
        child: GestureDetector(
          onTap: (){
            onNextWeek();
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: textColor,
            size: 20,
          ),
        )
      );
  }

  void onNextWeek() {
    setNextWeek();
  }

  void onPreviousWeek() {
    setPreviousWeek();
  }

  void setNextWeek() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 7));
      setNextWeekButtonVisibility();
      currentWeek = getWeekDisplayDate(selectedDate);
      getDailyStatList(selectedDate);
    });
  }
  void setNextWeekButtonVisibility() {
    setState(() {
      displayNextWeekBtn = !selectedDate.isSameDate(currentDate);
    });
  }

  void setPreviousWeek() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 7));
      setNextWeekButtonVisibility();
      currentWeek = getWeekDisplayDate(selectedDate);
      getDailyStatList(selectedDate);
    });
  }

  void setSelectedDayPosition(int position) {
          setState(() {
            dailyStatList1= (getDailyListWithSelectedDay(
              dailyStatList1,
              position));
          });

  }
  void resetMaxValue() {
    setState(() {
      maxSection1 = -1;
    });
  }

  int randomInt(int max) {
    return Random().nextInt(100) + 1;
  }

  Future<void> getDailyStatList(DateTime dateTime) async {

    setState(() {
      resetMaxValue();
      var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

      List<DailyStatUiModel> section1Stat = List.filled(7, defaultDailyStat);


      var today = DateTime.now();
      var todayPosition = DateTime.now().weekday - 1;

      for (var i = 0; i <= 6; i++) {
        var date = daysInWeek[i];
        selectTime.add(DateFormat('dd-MM-yyyy').format(date));
        print('selectTime>>${selectTime.length} >>>>${selectTime[i]}');


        var randomStat1 = randomInt(100);
        section1Stat[i] = DailyStatUiModel(
            day: date.toFormatString('EEE'),
            stat: selectTime[i],
            isToday: today.isSameDate(date),
            isSelected: todayPosition == i,
            dayPosition: i);

        if (maxSection1 < randomStat1) {
          maxSection1 = randomStat1;
        }

        dailyStatList1=(section1Stat);
        print('list length>     >> ${dailyStatList1.length}');
        print('list length>>> ${daysInWeek[i].day}');
      }
      if(userBox.isNotEmpty){
        getUserData();
      }

    });
  }
}
