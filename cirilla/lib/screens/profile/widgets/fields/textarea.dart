import 'package:cirilla/constants/styles.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

import 'validate_field.dart';

class AddressFieldTextArea extends StatefulWidget {
  final String? value;
  final ValueChanged<String> onChanged;
  final bool borderFields;
  final Map<String, dynamic> field;

  const AddressFieldTextArea({
    Key? key,
    this.value,
    this.borderFields = false,
    required this.onChanged,
    required this.field,
  }) : super(key: key);

  @override
  State<AddressFieldTextArea> createState() => _AddressFieldTextArea();
}

class _AddressFieldTextArea extends State<AddressFieldTextArea> with Utility {
  final _txtInputText = TextEditingController();

  @override
  void initState() {
    String defaultValue = get(widget.field, ['default'], '');
    _txtInputText.text = widget.value ?? defaultValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddressFieldTextArea oldWidget) {
    if (oldWidget.value != widget.value && widget.value != _txtInputText.text) {
      String defaultValue = get(widget.field, ['default'], '');
      _txtInputText.text = widget.value ?? defaultValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _txtInputText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    String label = get(widget.field, ['label'], '');
    String placeholder = get(widget.field, ['placeholder'], null);
    bool requiredInput = get(widget.field, ['required'], true);
    List validate = get(widget.field, ['validate'], []);
    String maxLength = get(widget.field, ['maxlength'], '');

    String? labelText = requiredInput ? '$label *' : label;
    int? inputMaxLength = maxLength.isNotEmpty ? ConvertData.stringToInt(maxLength) : null;

    return TextFormField(
      controller: _txtInputText,
      validator: (String? value) =>
          validateField(translate: translate, validate: validate, requiredInput: requiredInput, value: value),
      decoration: widget.borderFields == true
          ? InputDecoration(
              labelText: labelText,
              hintText: placeholder,
              contentPadding: const EdgeInsetsDirectional.only(
                  start: itemPaddingMedium, top: itemPaddingMedium, bottom: itemPaddingMedium),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.border?.borderSide ?? const BorderSide(),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.enabledBorder?.borderSide ?? const BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.focusedBorder?.borderSide ?? const BorderSide(),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.errorBorder?.borderSide ?? const BorderSide(),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.focusedErrorBorder?.borderSide ?? const BorderSide(),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: theme.inputDecorationTheme.disabledBorder?.borderSide ?? const BorderSide(),
              ),
            )
          : InputDecoration(
              labelText: labelText,
              hintText: placeholder,
            ),
      maxLines: 5,
      maxLength: inputMaxLength,
      onChanged: widget.onChanged,
    );
  }
}
