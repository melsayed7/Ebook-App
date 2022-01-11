import 'package:flutter/material.dart';
import 'package:ebook_app/app_colors.dart' as AppColors;

class AppTabs extends StatelessWidget {

  final String? text ;
  final Color? color ;
  const AppTabs({Key? key , this.text,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Text(
        text!,
        style: const TextStyle(
          fontSize: 16.0 ,
          color: Colors.white,
        ),
      ),
      alignment: Alignment.center,
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color:Colors.grey.withOpacity(.3),
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
        ],
      ),
    );
  }
}
