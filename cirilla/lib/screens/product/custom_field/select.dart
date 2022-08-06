import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class FieldSelect extends StatelessWidget with Utility {
  final dynamic value;
  final String? align;
  final Map choices;
  final String format;

  const FieldSelect({
    Key? key,
    this.value,
    this.align,
    this.choices = const {},
    this.format = 'value',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = align == 'center'
        ? TextAlign.center
        : align == 'right'
            ? TextAlign.end
            : TextAlign.start;
    late String text;
    switch (format) {
      case 'value':
        text = getStringValue(value, choices);
        break;
      case 'label':
        text = getStringLabel(value);
        break;
      case 'array':
        text = getStringArray(value);
        break;
      default:
        text = '';
    }
    return Text(text, textAlign: textAlign);
  }

  String getStringValue(dynamic data, Map optionChoices) {
    String label = data is String ? get(choices, [data], data) : '';
    return label;
  }

  String getStringLabel(dynamic data) {
    return data is String ? data : '';
  }

  String getStringArray(dynamic data) {
    late String text;
    if (data is Map) {
      String label = get(data, ['label'], '');
      text = label;
    } else {
      text = '';
    }
    return text;
  }
}
