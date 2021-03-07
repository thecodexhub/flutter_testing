import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing/common_widgets/string_validator.dart';

class ValidationTextField extends StatefulWidget {
  const ValidationTextField({
    Key key,
    this.inputDecoration,
    @required this.textEditingController,
    @required this.focusNode,
    @required this.keyboardType,
    @required this.inputFormatter,
    @required this.stringValidator,
    this.onEditingComplete,
    this.onChanged,
  }) : super(key: key);
  final InputDecoration inputDecoration;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final StringValidator stringValidator;
  final ValueChanged<String> onChanged;
  final Function() onEditingComplete;

  @override
  _ValidationTextFieldState createState() => _ValidationTextFieldState();
}

class _ValidationTextFieldState extends State<ValidationTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          decoration: widget.inputDecoration,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            widget.inputFormatter,
          ],
          style: const TextStyle(fontSize: 20.0),
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
        ),
      ],
    );
  }
}
