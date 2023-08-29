import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/response/status.dart';
import 'package:flutter_application_1/utils/app_urls.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Componts/sheduleWather.dart';
import '../utils/Colors.dart';
import '../view_model/home_view_model.dart';
import '../view_model/wather_view_model.dart';

class MyPostApi extends StatefulWidget {
  const MyPostApi({super.key});

  @override
  State<MyPostApi> createState() => _MyPostApiState();
}

class _MyPostApiState extends State<MyPostApi> {
  WatherViewModel homeViewViewModel = WatherViewModel();
  @override
  void initState() {
    homeViewViewModel.watherModelCurrent();
    homeViewViewModel.schduleListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: kWhite,
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/images/weaimg.png'),
          fit: BoxFit.cover,
        ),
        title: Text('Weather',
            style: TextStyle(
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: ChangeNotifierProvider<WatherViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<WatherViewModel>(builder: (context, value, _) {
          switch (value.watherList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.watherList.message.toString()));
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/weaimg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        value.watherList.data!.current!.last_updated.toString(),
                        style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value.watherList.data!.current!.temp_c.toString(),
                              style: TextStyle(
                                  color: kWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 330,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lblue,
                                    dblue,
                                  ]),
                              border: Border.all(width: 0.5, color: kwBorder),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 9,
                              ),
                              Center(
                                  child: Text(
                                "Hourly Forecast",
                                style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        maxLines: 4,
                                        value.watherList.data!.current!
                                            .condition!.text
                                            .toString(),
                                        style: TextStyle(
                                            color: kWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Image.network(
                                      'https://cdn.weatherapi.com/weather/64x64/day/353.png',
                                      height: 80,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/heat.png",
                                          height: 30, color: kWhite),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Min max Temp",
                                            style: TextStyle(
                                                color: kWhite, fontSize: 15),
                                          ),
                                          Text("19.0/19.0",
                                              style: TextStyle(
                                                  color: kWhite, fontSize: 15))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/humidity.png",
                                        height: 28,
                                        color: kWhite,
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Humidity",
                                            style: TextStyle(
                                                color: kWhite, fontSize: 15),
                                          ),
                                          Text(
                                              "${value.watherList.data!.current!.humidity.toString()} %",
                                              style: TextStyle(
                                                  color: kWhite, fontSize: 15))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/wind.png",
                                          height: 30, color: kWhite),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Wind Speed",
                                            style: TextStyle(
                                                color: kWhite, fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "${value.watherList.data!.current!.wind_mph.toString()} Mph",
                                              style: TextStyle(
                                                  color: kWhite, fontSize: 15))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/pressure.png",
                                        height: 28,
                                        color: kWhite,
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Pressure",
                                            style: TextStyle(
                                                color: kWhite, fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 9,
                                          ),
                                          Text(
                                              " ${value.watherList.data!.current!.pressure_mb.toString()} hpa %",
                                              style: TextStyle(
                                                  color: kWhite, fontSize: 15))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      lblue,
                                      dblue,
                                    ]),
                                border: Border.all(width: 0.5, color: kwBorder),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Today's Weather",
                                    style: TextStyle(
                                        color: kWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 210,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      //    physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: value.watherList.data!
                                          .forecast!.forecastday!.length,
                                      itemBuilder: (context, index) {
                                        final items = value
                                            .watherList
                                            .data!
                                            .forecast!
                                            .forecastday![index]!
                                            .hour;
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: items!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Center(
                                                        child: Text(
                                                          items[index]!
                                                              .time
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: kWhite,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Image.network(
                                                      'https://cdn.weatherapi.com/weather/64x64/night/122.png',
                                                      height: 45,
                                                    ),
                                                    Text(
                                                      items[index]!
                                                          .temp_c
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      }),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Divider(
                          color: kWhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lblue,
                                    dblue,
                                  ]),
                              border: Border.all(width: 0.5, color: kwBorder),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                
                            children: [
                             Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: Text(
                                      "Daily Forecast",
                                      style: TextStyle(
                                          color: kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                             ),
                              SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    //    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: value.watherList.data!.forecast!
                                        .forecastday!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value.watherList.data!.forecast!.forecastday![index]!.date.toString(),style: TextStyle(color: kWhite,fontSize: 17),),
                                          ),
                                          Image.network(AppUrls.IMAGEURL+value.watherList.data!.forecast!.forecastday![index]!.day!.condition!.icon.toString(),height: 70,),
                                          SizedBox(height: 5,),
                                           Text(value.watherList.data!.forecast!.forecastday![index]!.day!.maxtemp_c.toString(),style: TextStyle(color: kWhite,fontSize: 17),),
                                        ],
                                      );
                                    }),
                              ),
                           
                            ],
                          ),
                        ),
                      ),
                       Container(
                            
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lblue,
                                    dblue,
                                  ]),
                              border: Border.all(width: 0.5, color: kwBorder),
                              borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                                  Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: Text(
                                      "Daily Forecast",
                                      style: TextStyle(
                                          color: kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                             ), 
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: SizedBox(
                                height: 320,
                                 child: ListView.builder(
                                     
                                           physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: value.sheduleApiwatherList.data!.data.length,
                                        itemBuilder: (context, index) {
                                        final item =   value.sheduleApiwatherList.data!.data![index];
                                          return
                                   InkWell(
                                    onTap: (){
                                    Get.to(WatherScheduleDetails(item: item,));
                                    },
                                     child: Container( 
                                      decoration: BoxDecoration( 
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Column( 
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [ 
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "grapes",
                                              style: TextStyle(
                                                  color: kgreen,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "20 Arl 2022",
                                              style: TextStyle(
                                                  color: kgrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ), 
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 170,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration( 
                                               image: DecorationImage( 
                                                image: NetworkImage(value.sheduleApiwatherList.data!.data[index].sImage),
                                                fit: BoxFit.cover
                                               )
                                              ),
                                            ),
                                           
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 45,
                                              width: MediaQuery.of(context).size.width,
                                              child: Html( shrinkWrap: true,   data: value.sheduleApiwatherList.data!.data[index].description,)),
                                          ),
                                          Row( 
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [ 
                                            
                                              Icon(Icons.arrow_right_alt_sharp,color: klorange,) 
                                                                    
                                            ],
                                          ),
                                         
                                        ],
                                      ),
                                            ),
                                   );
                                        }
                                 ),
                               ),
                             )

                                ],
                              ),
                       ), 
                       SizedBox(height: 500,)
                      
                    ]),
                  ),
                ),
              );
          }
          return Container();
        }),
      ),
    );
  }
}
