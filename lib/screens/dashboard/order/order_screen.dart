import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/data/services/auth.dart';
import 'package:trekkers_project/screens/auth/Signup/components/body/body.dart';
import 'package:trekkers_project/screens/dashboard/payment/payment_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const String routeName = '/order';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => OrderScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  String contactPerson = "";
  String shippingAddress = "";
  String contactNumber="";
   @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find();
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      leading: IconButton(
        color: Colors.black,
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
        ),
        onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Order',style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.w800)),

      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                            SizedBox(
                                  height: 10.0,
                                ),
                              TextFormField( 
                                decoration:
                                    inputDecoration.copyWith(hintText: "Enter Your Name"),
                                validator: (value) =>
                                    value!.isEmpty ? "This Field is Required" : null,
                                onChanged: (value) {
                                  setState(() {
                                    contactPerson = value;
                                  });
                                },
                              ), 
                             SizedBox(
                                  height: 10.0,
                                ),
                              TextFormField(
                                decoration: inputDecoration.copyWith(
                                    hintText: "Enter Your Phone Number"),
                                validator: (value) => value!.length < 10
                                    ? "phone number must be of 10 digit"
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    contactNumber = value;
                                  });
                                },
                   
                              ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                 decoration: inputDecoration.copyWith(
                                     hintText: "Enter Your Shipping Address"),
                                 validator:(value) => value!.isEmpty ? "This Field is Required" : null,
                             
                                 onChanged: (value) {
                                   setState(() {
                                     shippingAddress = value;
                                   });
                                 },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                     Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () {


                        if (_formKey.currentState!.validate()) {
                           if (_formKey.currentState!.validate()) {
                            // setState(()  {
                            //   isLoading=true;
                            // });
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>PaymentScreen()
                        ));
                            // // await  _authService.userSignUp(email, password,phone);
                            // // msg=_authService.msg; 
                            // await authController.signupUser(email,password,phone);
                            // setState((){isLoading=false; });                       
                        }
                      }     
                      },
                      child: const Text('Order')
                    ),
                  ),

            
                ],
              ),
          ),
            ],
          )
        ),
      );
    
  }
}

