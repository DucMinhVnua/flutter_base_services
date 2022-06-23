import 'package:flutter/material.dart';

class ButtonDiaLog {
  final String textButton;
  final VoidCallback onPressed;
  final TextStyle? textStyleButton;

  ButtonDiaLog({
    required String this.textButton,
    required VoidCallback this.onPressed,
    this.textStyleButton,
  });
}

class DialogCustom {
  final BuildContext context;
  final String title;
  final String content;
  final TextStyle? styleTitle;
  final TextStyle? styleContent;
  final List<ButtonDiaLog> buttons;

  DialogCustom(
      {required this.context,
      required this.title,
      required this.content,
      this.styleTitle,
      this.styleContent,
      required this.buttons});
}

class ShowPopup extends DialogCustom {
  ShowPopup(
      {required BuildContext context,
      required String title,
      required String content,
      required List<ButtonDiaLog> buttons})
      : super(
            context: context, title: title, content: content, buttons: buttons);

  Future<void> show() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text("title", style: styleTitle),
          content: Text(content, style: styleContent),
          actions: [
            if (buttons.length == 1)
              Center(
                child: ElevatedButton(
                  child: Text("${buttons[0].textButton}",
                      style: buttons[0].textStyleButton),
                  onPressed: buttons[0].onPressed,
                ),
              )
            else
              Row(
                children: [
                  ...buttons.asMap().entries.map((button) {
                    var index = button.key;

                    return Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          right: index == buttons.length - 1 ? 0.0 : 5.0),
                      child: ElevatedButton(
                        child: Text("${button.value.textButton}",
                            style: button.value.textStyleButton),
                        onPressed: button.value.onPressed,
                      ),
                    ));
                  })
                ],
              )
          ]),
    );
  }
}
