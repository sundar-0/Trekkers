import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PlaceScreen extends StatefulWidget {
    static const String routeName = '/profile';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => PlaceScreen(),
        settings: RouteSettings(name: routeName));
  }
  const PlaceScreen({ Key? key }) : super(key: key);

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
    final Set<Marker> _markers = {};
    final Set<Polygon> _polygonSet = {};
    final Set <Polyline> _polylines={};
   // https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248c9563fec91f2487c8da28c73637886ee&start=8.681495,49.41461&end=8.687872,49.420318

    // final Completer<GoogleMapController> _controller = Completer();
    GoogleMapController? mapController; //controller for Google map
    final TextEditingController searchController = TextEditingController();

    List <String> search_places=[];
    //current position
    // double lat1=27.698600,lng1=85.333178;
    // double lat2=0.0,lng2=0.0;
    // Color color=Colors.lightBlue;
    // int tapped=0;
    String choosed_location="";
    bool is_searching=false;
    double distance_taken=0.0,time_taken=0.0;
    static LatLng startLocation = LatLng(27.6915,85.3425); 
    static LatLng endLocation=LatLng(0, 0);
    List<LatLng> latlng = [
  
    ];
    static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  @override
  void initState() {
    setMarker(startLocation);
    super.initState();
  }


 void showDescription(){
   showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5)),
  
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Distance ${double.parse(distance_taken.toStringAsFixed(2))} k.m'),
                            Text("Time ${double.parse(time_taken.toStringAsFixed(2))} Hrs"),
                          
                          ],
                        ),
                      ),
                    );
                  });
        
      }

  /*set marker based on the location*/
  void setMarker(LatLng latlong) {
      setState(() {
        _markers.add(
          Marker(
          markerId: MarkerId(getRandomString(10)),
          position: latlong,
          infoWindow: InfoWindow(
            title:"Some Text",
          ),  
          onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.amber,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Trip Your Packages'),
                            Text("Selected Destination:\n "),
                            ElevatedButton(
                              child: const Text('Confirm Destination'),
                              onPressed: () {
                                //find route api call
                                findRoute(startLocation,endLocation);
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },

          icon: BitmapDescriptor.defaultMarker,
        ));
      });
  }
  /*End of setMarker()*/
void addPolyLine(){
    setState((){
    _polylines.add(
      Polyline(
      polylineId:PolylineId(getRandomString(10)),
      points: latlng,
      consumeTapEvents: true,
      color: Colors.redAccent.shade700,     
      width: 3,
      startCap:Cap.buttCap,
      endCap: Cap.buttCap
      )
      );
    });
  }





  void findRoute(LatLng source,LatLng destination) async{
    print('https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248c9563fec91f2487c8da28c73637886ee&start=${source.longitude},${source.latitude}&end=${destination.longitude},${destination.latitude}');
    var response=await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248c9563fec91f2487c8da28c73637886ee&start=${source.longitude},${source.latitude}&end=${destination.longitude},${destination.latitude}'));
    if (response.statusCode == 200) {
    var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
    var route_coordinates=jsonResponse["features"][0]["geometry"]["coordinates"];
    distance_taken=jsonResponse["features"][0]["properties"]["summary"]["distance"]/1000;
    time_taken=jsonResponse["features"][0]["properties"]["summary"]["duration"]/3600;

    for(int i=0;i<route_coordinates.length;i++){
      setState(() {
        latlng.add(LatLng(route_coordinates[i][1],route_coordinates[i][0] ));

        mapController?.animateCamera( 
                          CameraUpdate.newCameraPosition(
                                CameraPosition(target: LatLng(route_coordinates[i][1],route_coordinates[i][0] ), zoom: 12) 
          ));  
      });
    }

      addPolyLine();
      showDescription();



  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  }
  // void setPolygon(){
  // List<LatLng> polygonCoords =[];
  // polygonCoords.add( LatLng(27.698702, 85.343178));
  // polygonCoords.add( LatLng(27.698605, 85.323188));
  // polygonCoords.add( LatLng(27.697100, 85.333278));
  // polygonCoords.add( LatLng(27.698600, 85.343178));
  //   setState(() {
  //    _polygonSet.add(
  //      Polygon(
  //        polygonId:PolygonId('test'),
  //        zIndex: 20,
  //        points: polygonCoords,
  //        strokeColor: Colors.red,
  //        fillColor: Colors.green
  //     ));
  //   });
  
  // }


  //  _addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.red, points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         "5b3ce3597851110001cf6248c9563fec91f2487c8da28c73637886ee",
//         PointLatLng(85.343178,27.698702),
//         PointLatLng(85.325021,27.687201),
//         travelMode: TravelMode.driving,
// );
// print("Polygon Results");
// print(result.points);
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     _addPolyLine();
//   }

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:GoogleMap(
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:CameraPosition(
                  target: startLocation,
                  zoom: 14.0,
                ),
        onMapCreated:(controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
        },
        markers: _markers,  
        polylines: _polylines,
      )
      ),
        Positioned(
          top: 25,
          left: 10,
          child: Container(
            padding:EdgeInsets.fromLTRB(10, 10, 10, 0) ,
              height:40,
              width: MediaQuery.of(context).size.width/2+MediaQuery.of(context).size.width/4,
              decoration: BoxDecoration(
                color:Colors.lime[50],
                borderRadius: BorderRadius.circular(20)
              ),
              child:TextField(
                  onChanged:fetchPlaces,
                  controller: searchController,
                  
                  onSubmitted: (value){ 
                 
                  setState(() {
                    is_searching=true;
               
                  });
                  setMarker(endLocation);
                  mapController?.animateCamera( 
                          CameraUpdate.newCameraPosition(
                                CameraPosition(target: endLocation, zoom: 14) 
                          ));
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
        ),
      Positioned(
        top: 20,
        right: 110,
        child: IconButton(onPressed: (){}, icon: Icon(Icons.search),iconSize: 40,)),
      Positioned(
        top: 65,
        child: SingleChildScrollView(
          child:search_places.length!=0 ?Container(
            height: MediaQuery.of(context).size.height/2,
            padding: EdgeInsets.fromLTRB(5, 5,0, 0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,border:Border.all(width: 2),borderRadius: BorderRadius.circular(5)),
            child: ListView.builder(
              itemCount: search_places.length,
              itemBuilder: (context, index) => Material(
                child: ListTile(
                  title: Text(search_places[index]),
                   onTap: (){
                    endLocation=calculateLatLng(search_places[index]);
                     setState(() {
                     search_places=[];
                   });
                   },
                ),
              )),
          ):Text(""),
        ),
      )
      ],
    );
  }

}


