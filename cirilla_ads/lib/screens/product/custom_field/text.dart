import 'package:cirilla/utils/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FieldText extends StatefulWidget {
  final dynamic value;
  final String? align;
  final String type;

  const FieldText({
    Key? key,
    this.value,
    this.align,
    this.type = 'text',
  }) : super(key: key);

  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  late bool hintText;

  @override
  void initState() {
    hintText = widget.type == 'password';
    super.initState();
  }

  void launchType(String data) {
    if (emailValidator(value: data, errorEmail: 'e') != 'e') {
      launch("mailto:$data");
    } else {
      bool validURL = Uri.parse(data).isAbsolute;
      if (validURL) {
        launch(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = widget.align == 'center'
        ? TextAlign.center
        : widget.align == 'right'
            ? TextAlign.end
            : TextAlign.start;

    String text = widget.value is String ? widget.value : '';
    Widget textWidget = Text(
      hintText ? List<String>.filled(text.length, '', growable: true).join('·') : text,
      textAlign: textAlign,
      style: hintText
          ? const TextStyle(
              fontSize: 30,
              letterSpacing: 0.7,
              height: 21 / 30,
              leadingDistribution: TextLeadingDistribution.even,
            )
          : null,
    );

    if (widget.type == 'password') {
      return Row(
        children: [
          InkResponse(
            onTap: () => setState(() {
              hintText = !hintText;
            }),
            child: Icon(
              hintText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: textWidget,
          ),
        ],
      );
    }

    if (widget.type == 'email' || widget.type == 'url') {
      AlignmentGeometry alignment = widget.align == 'center'
          ? AlignmentDirectional.center
          : widget.align == 'right'
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart;
      return TextButton(
        onPressed: () => launchType(text),
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.bodyText2,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          alignment: alignment,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: textWidget,
      );
    }
    return textWidget;
  }
}
