
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trekkers_project/constants/constants.dart';

import 'package:trekkers_project/controllers/auth_controller.dart';
class EventDetails extends StatefulWidget {
    static const String routeName = '/eventdetails';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => EventDetails(),
        settings: RouteSettings(name: routeName));
  }
  const EventDetails({ Key? key }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
   final AuthController authController=Get.find();
   String? token;
   var eventDetails=[];
  @override
  void initState() {
    super.initState();
    setState(() {
      token=authController.token.value;
    });
    fetcheventDetails();
  }
  var eventlists=[
    {
      "user":"hari",
      "going":"pokhara",
      "interested":"4",
    },
    {
      "user":"shyam",
      "going":"ghandruk",
      "interested":"10",
    },
    {
      "user":"bibek",
      "going":"australia",
      "interested":"12",
    }
  ];
  

Future fetcheventDetails() async{
  var header={
    "Authorization":"Bearer $token"
  };
 final response=await http.get(Uri.parse("$baseUrl/event/fetchevent"),headers: header);

  if (response.statusCode == 200) {
    final data=jsonDecode(response.body.toString()); 
    final result=data["result"];
    setState(()  {
      eventDetails= result;
    });
  }
  else{
    eventDetails=[];
  }
  print(eventDetails);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
      title: const Text('Event Details',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      
      ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
          Expanded(
            child: ListView.builder(
            itemCount:eventDetails.length ,
            itemBuilder: (context,int index){
              return EventDescriptor(
                eventCreator:eventDetails[index]['event_creator']['email'].split("@")[0],
                usersGoing:eventDetails[index]['users_going'],
                placesGoing: eventDetails[index]['places_going'],
                eventDate: eventDetails[index]['event_date'],
                eventTime:eventDetails[index]['event_time'],
                estimatedDay:eventDetails[index]['estimated_day']??0
              );
            } ),
          )]
          ),
     ),
        );


  }
}

class EventDescriptor extends StatefulWidget {
  final String eventCreator;
  final List usersGoing;
  final List placesGoing;
  final String eventDate;
  final String eventTime;
  final int estimatedDay;
  const EventDescriptor({
    Key? key,
    required this.eventCreator,
    required this.usersGoing,
    required this.placesGoing,
    required this.eventDate,
    required this.eventTime,
    required this.estimatedDay,
  }) : super(key: key);

  @override
  State<EventDescriptor> createState() => _EventDescriptorState();
}

class _EventDescriptorState extends State<EventDescriptor> {
  List options=["going","not going"];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
                  Text("${widget.eventCreator}",style: TextStyle(fontFamily: 'sans-serif',fontWeight: FontWeight.w800,fontSize: 16),),
                  SizedBox(width:2),
                  Text("is going to:")
          ],
        ),
      SizedBox(height: 20,),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: widget.placesGoing.length, 
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(4),
                      width: 85,
                      height:40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amberAccent.shade100
                        ),
                        child: Center(child: Text(widget.placesGoing[index])));
            }),
        ),
      SizedBox(height: 20,),
      Row(
          children: [
                    RichText(   
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.date_range,
                          ),
                        ),
                        ),
                      TextSpan(text: widget.eventDate,style:TextStyle(color: Colors.black) ),
                      ],
                    ),
                  ),
                SizedBox(width: 15,),                   
                 RichText(   
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.alarm,
                          ),
                        ),
                        ),
                      TextSpan(text: widget.eventTime,style:TextStyle(color: Colors.black) ),
                      ],
                    ),
                  ),  
          ],
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 150,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context,index){
                return CustomPoll(index:index,option: options[index],numOfGoing:widget.usersGoing.length);
              }
              )
      ),
      ],
    );
  }
}

class CustomPoll extends StatefulWidget {
  final String option;
  final int index;
  final int numOfGoing;
  const CustomPoll({
    required this.index,
    required this.option,
    required this.numOfGoing
  });

  @override
  State<CustomPoll> createState() => _CustomPollState();
}

class _CustomPollState extends State<CustomPoll> {
  Color customcolor=Colors.white;
   int ?numberOfGoing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){  
              print(customcolor);  
              if(customcolor==Colors.white)
              {
                Color color=Colors.blue.shade700;
                setState(() {
                  customcolor=color;
                  numberOfGoing=widget.numOfGoing+1;
                });
              } 
             else
             {
                Color color=Colors.white;
                 setState(() {
                  customcolor=color;
                });
            }  
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(child: Text(widget.option)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400,width: 2),
                borderRadius: BorderRadius.circular(20),
                color: customcolor
              ),
              ),
          ),
          (widget.index==0 && customcolor==Colors.blue.shade700)?GestureDetector(onTap:(){
            print("Interested");
          },child:Text("$numberOfGoing people going")):Text(""),
            SizedBox(height:4,)
        ],
      ),
    );
  }
}

