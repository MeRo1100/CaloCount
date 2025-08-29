import 'package:flutter/material.dart';
import 'package:ketodiet/screens/homemain/tab_screen/calories_statistics.dart';
import 'package:ketodiet/utils/colors_utils.dart';
import 'package:ketodiet/utils/myspacer.dart';
import 'package:ketodiet/widgets/myappbar.dart';
import 'package:ketodiet/widgets/mycontainer.dart';
import 'package:ketodiet/widgets/myregulartext.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
 /* final List<CaloriesModel> data = [
    CaloriesModel(
      weeks: "2008",
      calories: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2009",
      calories: 11000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2010",
      calories: 12000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2011",
      calories: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2012",
      calories: 8500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2013",
      calories: 7700000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2014",
      calories: 7600000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    CaloriesModel(
      weeks: "2015",
      calories: 5500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: MyAppBar.myAppBar(context,'Statistics',true,(){
        Navigator.pop(context);
      },(){} ,primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CaloriesStatistics(),
              MySpacer.spacer30,
              const MyRegularText( isHeading: true,label: 'Recipes Ideas',fontWeight: FontWeight.w600,fontSize: 20,),
              MySpacer.mediumspacer,
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.6,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return MySpacer.width16;
                  },
                  padding: const EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return MyContainer(
                        width: MediaQuery.of(context).size.width / 1.8,
                       // height: MediaQuery.of(context).size.height / 9,
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 8,
                              child: ClipRRect(
                                  borderRadius:const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                  ),
                                  child: Image.network('https://img.freepik.com/free-photo/front-view-served-table-with-cocktails_141793-6095.jpg?w=740&t=st=1682169830~exp=1682170430~hmac=1d39edf15a7c21102e8023f652700d2f18cd18b5c06ee9ae84f8ea105f3bbd57',fit: BoxFit.cover,)),
                            ),
                            MyContainer(
                              borderRadius:const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height /11,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Flexible(
                                              flex:1,
                                              child: MyRegularText(
                                                isHeading: true,
                                                label: 'Full Course Dinner',
                                                fontSize: 16,
                                                align: TextAlign.start,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            MySpacer.width6,
                                            const Icon(Icons.access_time_rounded,color: textColor1,size: 20,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Flexible(
                                              flex:2,
                                              child: MyRegularText(
                                                isHeading: false,
                                                label: 'Full Course Dinner in near by of your area.',
                                                fontSize: 13,
                                                color: Colors.grey,
                                                align: TextAlign.start,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            MySpacer.width2,
                                            const Flexible(
                                              flex:1,
                                              child: MyRegularText(
                                                isHeading: false,
                                                label: '45 m',
                                                fontSize: 14,
                                                color: Colors.grey,
                                                align: TextAlign.start,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                ),
                              ),
                            )

                          ],
                        ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
