
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
class EventScreen extends StatefulWidget {
  static const String routeName = '/event';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => EventScreen(),
        settings: RouteSettings(name: routeName));
  }
  const EventScreen({ Key? key }) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
    final AuthController authController=Get.find();
    String? token;
    List <String> search_places=[];
    List choosed_location=[];
    bool is_searching=false;
    final TextEditingController searchController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    DateTime dateTime = DateTime.now();
    bool showDateTime = false;
    static LatLng endLocation=LatLng(0, 0);

    @override
  void initState() {
    super.initState();
    setState(() {
      token=authController.login.value.token;
    });
  }

void removeTagLocation(int index){
      choosed_location.removeAt(index);
      showDateTime=false;
      setState(() {   
      });
    }
void fetchPlaces(String place) async{
    //make a Api call;
    if(place!=""){
    var response=await http.get(Uri.parse(
        'https://py4e-data.dr-chuck.net/json?key=42&address=$place'));
   if (response.statusCode == 200) {
    var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
    if(jsonResponse["results"].length!=0){
          var address = jsonResponse['results'][0]['formatted_address'];
          var lat= double.parse(jsonResponse['results'][0]['geometry']['location']['lat'].toStringAsFixed(4));
          var long= double.parse(jsonResponse['results'][0]['geometry']['location']['lng'].toStringAsFixed(4));
          // var long=jsonResponse['results'][0]['location']['long'];
          print('Address Name: $address.');
          print('Lat: $lat.');
          print('Long: $long.');
          // locations.add(jsonResponse["results"][0]);
          setState(() {
            !search_places.contains("$address $lat $long")?
            search_places=["$address $lat $long",...search_places]:"";
         
          });
          print("\n");
          // print(locations);
    }
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  }
  else{
    setState((){search_places=[];});
  }
}
LatLng calculateLatLng(String place){
  var list=place.split(" ");
  double lat2=double.parse(list[list.length-2]);
  double lng2=double.parse(list[list.length-1]);
  LatLng pos=LatLng(lat2,lng2);
  return pos;
}
String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm a').format(dateTime);
    }
  }
// Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }
// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
      if (date == null) return;

    final time = await _selectTime(context);

      if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }
  Future addeventDetails(List selectedLocations,String dateTime) async{
    String user=decodeToken(token!, SecretKey('secret'));
    // print(user);
    // print(selectedLocations);

    var data={
        "eventCreator":user,
        "eventDate":dateTime.split(" ")[0],
        "eventTime":dateTime.split(" ")[1]+" "+dateTime.split(" ")[2],
        "placesGoing":selectedLocations,
    };
    var options={
      'Content-Type': 'application/json; charset=UTF-8',
       "Authorization":"Bearer $token"
    };

    final response= await http.post(Uri.parse('http://10.0.2.2:5000/api/event/addevent'),headers: options,body: jsonEncode(data));
 

  if (response.statusCode == 200) {
    print('created');
  }
  else{
    print("error");
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      elevation: 0,
      title: const Text('Events',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
   
        Text("Where Are You Going?",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400)),
        SizedBox(height: 8,),
        Container(
            padding:EdgeInsets.fromLTRB(10, 10, 10, 0) ,
            height:40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color:Colors.lime[100],
              borderRadius: BorderRadius.circular(20)
            ),
            child:TextField(
                onChanged:fetchPlaces,
                controller: searchController,
                
                onSubmitted: (value){ 
               
                setState(() {
                  is_searching=true;
             
                });
              },
              decoration: InputDecoration(
                hintText: 'Type Something...',
                hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                ),
                border: InputBorder.none,
                ),
                style: TextStyle(
                color: Colors.black,
                ),
         )
        ),
          search_places.isNotEmpty ?SingleChildScrollView(
            child: Container(
              height:150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.orange[200],border:Border.all(width: 2,color: Colors.grey),borderRadius: BorderRadius.circular(5)),
              child: ListView.builder(
                itemCount: search_places.length,
                itemBuilder: (context, index) => Material(
                  child: ListTile(
                    title: Text(search_places[index]),
                     onTap: (){
                     choosed_location.add(search_places[index]);
                     endLocation=calculateLatLng(search_places[index]);
                  
                       setState(() {
                       search_places=[];
                     });
                     },
                  ),
                )),
            ),
          ):Text(""),
        Container(
            height: 80,
            child: ListView.builder(
                itemCount: choosed_location.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return LocationTagTile(
                    index: index,
                    location:choosed_location[index],
                    handler:removeTagLocation
                    );
                }),
          ),
       choosed_location.isNotEmpty? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _selectDateTime(context);
                  showDateTime = true;
                },
                child: Text(showDateTime==true?getDateTime():'Select Date and Time'),
              ),
            ):Text(""),
           SizedBox(height: 20,),
           showDateTime==true? ElevatedButton(onPressed: (){
            addeventDetails(choosed_location,getDateTime());
            // Navigator.of(context).pushNamed('/eventdetails');
           }, child: Text("Create Event")):Text(""),

          ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed('/eventdetails');
           }, child: Text("View All Events")),

        ],),
      )   
    );
  }
}
class LocationTagTile extends StatelessWidget {
  final int index;
  final String location;
  final Function handler;
  const LocationTagTile({
    Key? key,
    required this.index,
    required this.location,
    required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            width: 85,
            height:40,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(5),color: Colors.grey[300] ),
            child: Text(location),
          ),
          Positioned(
            top:-18,
            right: -18,
            child:IconButton(onPressed:()=>handler(index) , icon: Icon(Icons.clear,color: Colors.amber,size: 20,))
            )
        ],
      ),
    );
  }
}
