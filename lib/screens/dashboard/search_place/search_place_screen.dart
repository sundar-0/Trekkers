import 'package:flutter/material.dart';
class SearchPlaceScreen extends StatelessWidget {
    static const String routeName = '/search_place';
    static Route route() {
    return MaterialPageRoute(
        builder: (_) => SearchPlaceScreen(),
        settings: RouteSettings(name: routeName));
  }
  const SearchPlaceScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}