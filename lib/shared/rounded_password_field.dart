import 'package:flutter/material.dart';
import 'package:trekkers_project/constants/constants.dart';
import 'package:trekkers_project/shared/text_field_container.dart';


class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isHidden=true;
  Icon customIcon= Icon(Icons.visibility);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isHidden,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration:InputDecoration(
          hintText: "Password",
          icon:Icon(Icons.lock,color: kPrimaryColor),
          suffixIcon: IconButton(
            icon:customIcon,
            color: kPrimaryColor,
            onPressed: () {
              setState(() {
                if(customIcon.icon==Icons.visibility){
                  customIcon=const Icon(Icons.visibility_off);
                  isHidden=false;
                }
                else{
                customIcon=const Icon(Icons.visibility);
                isHidden=true;
                }
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
