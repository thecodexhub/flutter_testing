import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing/string_validator.dart';

class ValidationTextField extends StatefulWidget {
  const ValidationTextField({
    Key key,
    this.inputDecoration,
    @required this.submitText,
    @required this.keyboardType,
    @required this.inputFormatter,
    @required this.stringValidator,
    this.onSubmit,
  }) : super(key: key);
  final InputDecoration inputDecoration;
  final String submitText;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final StringValidator stringValidator;
  final ValueChanged<String> onSubmit;

  @override
  _ValidationTextFieldState createState() => _ValidationTextFieldState();
}

class _ValidationTextFieldState extends State<ValidationTextField> {
  final FocusNode _focusNode = FocusNode();
  String _value = '';

  void _submit() async {
    final bool isValid = widget.stringValidator.isValid(_value);
    if (isValid) {
      _focusNode.unfocus();
      widget.onSubmit(_value);
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          focusNode: _focusNode,
          decoration: widget.inputDecoration,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            widget.inputFormatter,
          ],
          style: const TextStyle(fontSize: 30.0),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          onEditingComplete: _submit,
        ),
        const SizedBox(height: 16.0),
        _buildButton(),
      ],
    );
  }

  Widget _buildButton() {
    final bool _isValid = widget.stringValidator.isValid(_value);
    return SizedBox(
      height: 45.0,
      child: ElevatedButton(
        onPressed: !_isValid ? null : () {},
        child: Text(
          widget.submitText,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
