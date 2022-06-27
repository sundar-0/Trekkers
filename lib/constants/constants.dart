import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const inputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0))),
);
String decodeToken(String token,SecretKey secretKey){
  try {
      final jwt = JWT.verify(token, secretKey);
      final payload=jwt.payload;
      String userId=payload['userid']; 
      return userId;
    } on JWTExpiredError {
      return "";
    } on JWTError catch (ex) {
     return ex.message;
    }
  }

  const baseUrl="http://trekkersapi.herokuapp.com/api";