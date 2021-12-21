import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loftfin/strings.dart';
import 'package:loftfin/style/app_theme.dart';

class OutlineTextField extends StatefulWidget {
  final String title;
  final bool isError;
  final bool isOptional;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final Function? validator;
  OutlineTextField({
    required this.title,
    required this.isError,
    required this.controller,
    required this.keyboardType,
    this.isOptional = false,
    this.focusNode,
    this.nextFocusNode,
    this.inputFormatter,
    this.maxLength,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _OutlineTextFieldState createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
  bool _isError = false;
  bool _validationError = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isError) {
      if (widget.controller.text == '') {
        _isError = true;
        _validationError = false;
      } else {
        if (widget.validator != null) {
          if (widget.validator!(widget.controller.text)) {
            _isError = false;
            _validationError = false;
          } else {
            _isError = true;
            _validationError = true;
          }
        } else {
          _isError = false;
          _validationError = false;
        }
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: AppTheme.textStyleSmall.copyWith(
                color: _isError ? AppTheme.red : AppTheme.black,
              ),
            ),
            Spacer(),
            _isError
                ? Icon(
                    Icons.error,
                    color: AppTheme.red,
                  )
                : Container(),
            widget.isOptional
                ? Text(
                    kStringsOptional,
                    style: AppTheme.textStyleSmall.copyWith(
                      color: AppTheme.textButtonColor,
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              width: 1,
              color: Colors.black26,
            ),
          ),
          child: Center(
            child: TextFormField(
              onChanged: (value) {
                if (_isError) {
                  setState(() {
                    _isError = !_isError;
                  });
                }
              },
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {
              //   return widget.validator != null
              //       ? widget.validator!(value)
              //       : null;
              // },
              inputFormatters: widget.inputFormatter ?? [],
              maxLines: 1,
              maxLength: widget.maxLength ?? 40,
              textAlign: TextAlign.left,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                counterText: '',
                // hintText: title,
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              focusNode: widget.focusNode,
              onFieldSubmitted: (v) {
                widget.nextFocusNode ??
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
              },
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
        _isError
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (_validationError
                          ? kStringsPleaseEnterValid
                          : kStringsPleaseEnter) +
                      widget.title,
                  style: AppTheme.textStyleSmall.copyWith(
                    color: AppTheme.red,
                  ),
                ),
              )
            : Container(),
      ],
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       title,
    //       style: TextStyle(
    //         color: AppTheme.textColor,
    //       ),
    //     ),
    //     SizedBox(height: 10),
    //     TextFormField(
    //       autovalidateMode: AutovalidateMode.always,
    //       /* autovalidate is set to true */
    //       // controller: stateController,
    //       // inputFormatters: [
    //       //   FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
    //       //   FilteringTextInputFormatter.deny(RegExp(
    //       //       r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
    //       // ],
    //       keyboardType: TextInputType.text,
    //       maxLength: 160,
    //       onChanged: (val) {},
    //       maxLines: 1,
    //       validator: (value) {
    //         // int res = validateAddress(value);
    //         // if (res == 1) {
    //         //   return "Please enter state";
    //         // } else {
    //         //   return null;
    //         // }
    //       },
    //       // focusNode: stateFocus,
    //       autofocus: false,
    //       decoration: InputDecoration(
    //         errorMaxLines: 1,
    //         counterText: "",
    //         filled: true,
    //         fillColor: Colors.white,
    //         focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(4)),
    //           borderSide: BorderSide(
    //             width: 1,
    //             color: Colors.black54,
    //           ),
    //         ),
    //         enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(4)),
    //           borderSide: BorderSide(
    //             width: 1,
    //             color: Colors.black26,
    //           ),
    //         ),
    //         errorBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(4)),
    //             borderSide: BorderSide(
    //               width: 1,
    //               color: Colors.red,
    //             )),
    //         focusedErrorBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(4)),
    //           borderSide: BorderSide(
    //             width: 1,
    //             color: Colors.red,
    //           ),
    //         ),
    //         hintText: title,
    //       ),
    //     ),
    //   ],
    // );
  }
}
