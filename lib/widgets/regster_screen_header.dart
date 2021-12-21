import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loftfin/style/app_theme.dart';
import 'package:loftfin/widgets/page_indicator.dart';

import '../strings.dart';

class RegisterScreenHeader extends StatelessWidget {
  final int pageIndex;
  final String subTitle;
  final bool showPagination;

  const RegisterScreenHeader({
    required this.pageIndex,
    required this.subTitle,
    this.showPagination = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      height: showPagination ? size.height * 0.24 : size.height * 0.20,
      width: size.width,
      decoration: BoxDecoration(
        color: AppTheme.blue,
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: AppTheme.textStyleSmall,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      kStringsCancel,
                      style: AppTheme.textStyleSmall,
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    kStringsRegisterLoft,
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyleHeading,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            subTitle,
            style: AppTheme.textStyleSmall,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          showPagination
              ? PageIndicator(index: pageIndex)
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}
