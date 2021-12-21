import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final String title;
  final Color backgroundColor;
  final Function onClick;
  final double height;
  const CustomButton({
    required this.title,
    required this.width,
    required this.backgroundColor,
    required this.onClick,
    this.height = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: height, //MediaQuery.of(context).size.width * .08,
            width: width, //MediaQuery.of(context).size.width * .3,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: backgroundColor,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  get borderRadius => BorderRadius.circular(height / 2);
}
