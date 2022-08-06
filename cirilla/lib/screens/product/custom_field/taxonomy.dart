import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class FieldTaxonomy extends StatelessWidget with Utility {
  final dynamic value;
  final String? align;
  final String format;

  const FieldTaxonomy({Key? key, this.value, this.align, this.format = 'object'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value is! List || (value is List && value.isEmpty == true)) {
      return Container();
    }
    late String text;
    switch (format) {
      case 'object':
        text = getObject(value);
        break;
      case 'id':
        text = getStringId(value);
        break;
      default:
        text = '';
    }
    TextAlign textAlign = align == 'center'
        ? TextAlign.center
        : align == 'right'
            ? TextAlign.end
            : TextAlign.start;
    return Text(text, textAlign: textAlign);
  }

  String getObject(List data) {
    List<String> arrLabel = [];
    for (var item in data) {
      if (item is Map) {
        String label = get(item, ['name'], '');
        arrLabel.add(label);
      }
    }
    return arrLabel.join(', ');
  }

  String getStringId(List data) {
    List<String> arrLabel = [];
    for (var item in data) {
      arrLabel.add('$item');
    }
    return arrLabel.join(', ');
  }
}
