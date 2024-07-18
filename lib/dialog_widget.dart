import 'package:flutter/material.dart';

class FormInputWidget extends StatelessWidget {
  final firstInputController = TextEditingController();
  final secondInputController = TextEditingController();
  String firstTextButton = "";
  String secondTextButton = "";
  String hintFirstInput = "";
  String hintSecondInput = "";
  Color firstButtonColor = Colors.grey;
  Color secondButtonColor = Colors.grey;
  double margin = 0;
  Function(String, String)? onClickFirstButton;
  Function(String, String)? onClickSecondButton;

  FormInputWidget({
    String? hintFirstInput,
    String? hintSecondInput,
    String? firstTextButton,
    String? secondTextButton,
    Color? firstButtonColor,
    Color? secondButtonColor,
    double? margin,
    Function(String, String)? onClickFirstButton,
    Function(String, String)? onClickSecondButton,
  }) {
    this.hintFirstInput = hintFirstInput ?? "";
    this.hintSecondInput = hintSecondInput ?? "";
    this.firstTextButton = firstTextButton ?? "";
    this.secondTextButton = secondTextButton ?? "";
    this.firstButtonColor = firstButtonColor ?? Colors.grey;
    this.secondButtonColor = secondButtonColor ?? Colors.grey;
    this.margin = margin ?? 0;
    this.onClickFirstButton = onClickFirstButton;
    this.onClickSecondButton = onClickSecondButton;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstInputController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintFirstInput,
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          TextField(
            controller: secondInputController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintSecondInput,
            ),
            textInputAction: TextInputAction.done,
            maxLines: 1,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Row(
            children: [
              Expanded(child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(firstButtonColor),
                ),
                onPressed: () { onClickFirstButton?.call(firstInputController.text, secondInputController.text); },
                child: Text(firstTextButton, style: TextStyle(color: Colors.white)),
              )),
              SizedBox(width: 20),
              Expanded(child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(secondButtonColor),
                ),
                onPressed: () { onClickSecondButton?.call(firstInputController.text, secondInputController.text); },
                child: Text(secondTextButton, style: TextStyle(color: Colors.white)),
              )),
            ],
          )
        ],
      ),
    );
  }
}
