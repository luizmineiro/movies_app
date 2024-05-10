import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/buttons/button_widget.dart';
import 'package:movies_app/core/widgets/texts/text_widget.dart';

class ErrorWithButtonWidget extends StatelessWidget {
  final String errorMessage;
  final void Function() tryAgain;
  const ErrorWithButtonWidget({
    super.key,
    required this.errorMessage,
    required this.tryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget.normal(
          errorMessage,
          textAlign: TextAlign.center,
        ),
        ButtonWidget(label: "Tentar Novamente", onPressed: tryAgain)
      ],
    );
  }
}
