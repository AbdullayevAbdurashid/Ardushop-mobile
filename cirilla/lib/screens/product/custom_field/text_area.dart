import 'package:cirilla/widgets/cirilla_html.dart';
import 'package:flutter/material.dart';

class FieldTextArea extends StatelessWidget {
  final dynamic value;
  final String? align;
  final String line;

  const FieldTextArea({
    Key? key,
    this.value,
    this.align,
    this.line = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = align == 'center'
        ? TextAlign.center
        : align == 'right'
            ? TextAlign.end
            : TextAlign.start;

    String text = value is String ? value : '';
    if (line == 'br' || line == 'wpautop') {
      return CirillaHtml(html: '<div>$text</div>');
    }
    return Text(
      text,
      textAlign: textAlign,
    );
  }
}
