import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/address/country_address.dart';
import 'package:flutter/material.dart';

import 'fields/fields.dart';

class AddressFieldForm3 extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final Map<String, dynamic>? data;
  final Map<String, dynamic> addressFields;
  final Function(Map<String, dynamic>) onChanged;
  final Function(String) onGetAddressData;
  final Widget? titleModal;
  final List<CountryAddressData> countries;
  final Map<String, List<CountryAddressData>> states;
  final bool borderFields;

  const AddressFieldForm3({
    Key? key,
    this.formKey,
    this.titleModal,
    this.borderFields = false,
    required this.addressFields,
    required this.data,
    required this.onChanged,
    required this.onGetAddressData,
    this.countries = const [],
    this.states = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (addressFields.isEmpty) {
      return Container();
    }

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthView =
            constraints.maxWidth != double.infinity ? constraints.maxWidth : MediaQuery.of(context).size.width;
        List<String> keys = addressFields.keys.toList();
        return Form(
          key: formKey,
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 0,
              runSpacing: itemPaddingMedium,
              children: [
                if (titleModal != null)
                  Container(
                    width: widthView,
                    padding: const EdgeInsets.only(bottom: itemPaddingExtraLarge),
                    child: Center(
                      child: titleModal,
                    ),
                  ),
                ...List.generate(
                  keys.length,
                  (index) {
                    String key = keys.toList()[index];
                    Map<String, dynamic> field = addressFields[key];

                    String type = get(field, ['type'], '');
                    String position = get(field, ['position'], 'form-row-wide');
                    String name = get(field, ['name'], '');

                    late Widget child;
                    switch (type) {
                      case 'text':
                        child = AddressFieldText(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'heading':
                        child = AddressFieldHeading(field: field);
                        break;
                      case 'email':
                        child = AddressFieldEmail(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'tel':
                        child = AddressFieldPhone(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'textarea':
                        child = AddressFieldTextArea(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'password':
                        child = AddressFieldPassword(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'select':
                        child = AddressFieldSelect(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'radio':
                        child = AddressFieldRadio(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'checkbox':
                        child = AddressFieldCheckbox(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                        );
                        break;
                      case 'time':
                        child = AddressFieldTime(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'date':
                        child = AddressFieldDate(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'number':
                        child = AddressFieldNumber(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'country':
                        child = AddressFieldCountry(
                          value: data?[name],
                          countries: countries,
                          field: field,
                          onChanged: (String value) {
                            Map<String, dynamic> stateData = {};
                            for (var fieldData in addressFields.values) {
                              if (fieldData is Map &&
                                  get(fieldData, ['type'], '') == 'state' &&
                                  get(fieldData, ['country_field'], '') == key) {
                                String nameState = get(fieldData, ['name'], '');
                                List<CountryAddressData>? stateList = states[value];
                                stateData.addAll({
                                  nameState: stateList?.isNotEmpty == true ? stateList![0].code : '',
                                });
                              }
                            }
                            onChanged({...?data, ...stateData, name: value});
                            onGetAddressData(value);
                          },
                          borderFields: borderFields,
                        );
                        break;
                      case 'state':
                        String countryField = get(field, ['country_field'], '');
                        Map<String, dynamic>? fieldCountry = addressFields[countryField];
                        String? nameCountry = get(fieldCountry, ['name']);
                        String? valueCountry = nameCountry != null ? get(data, [nameCountry]) : null;
                        List<CountryAddressData>? stateData = states[valueCountry];
                        child = AddressFieldState(
                          value: data?[name],
                          states: stateData ?? [],
                          field: field,
                          onChanged: (String value) {
                            onChanged({
                              ...?data,
                              name: value,
                            });
                          },
                          borderFields: borderFields,
                        );
                        break;
                      case 'multiselect':
                        child = AddressFieldMultiSelect(
                          value: data?[name],
                          onChanged: (List value) => onChanged({...?data, name: value}),
                          field: field,
                        );
                        break;
                      case 'multicheckbox':
                        child = AddressFieldMultiCheckbox(
                          value: data?[name],
                          onChanged: (List value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      case 'colorpicker':
                        child = AddressFieldColorPicker(
                          value: data?[name],
                          onChanged: (String value) => onChanged({...?data, name: value}),
                          field: field,
                          borderFields: borderFields,
                        );
                        break;
                      default:
                        child = Container();
                    }
                    if (position == 'form-row-wide') {
                      return SizedBox(
                        width: widthView,
                        child: child,
                      );
                    }

                    if (position == 'form-row-last') {
                      String? preKey = index > 0 ? keys[index - 1] : null;
                      Map<String, dynamic>? preField = preKey != null ? addressFields[preKey] : null;
                      String prePosition = get(preField, ['position'], 'form-row-wide');
                      if (prePosition != 'form-row-first') {
                        return Container(
                          width: widthView,
                          alignment: AlignmentDirectional.topEnd,
                          child: SizedBox(
                            width: (widthView - itemPaddingMedium) / 2,
                            child: child,
                          ),
                        );
                      }
                    }

                    if (position == 'form-row-first') {
                      String? nextKey = index < keys.length - 1 ? keys[index + 1] : null;
                      Map<String, dynamic>? nextField = nextKey != null ? addressFields[nextKey] : null;
                      String nextPosition = get(nextField, ['position'], 'form-row-wide');
                      if (nextPosition != 'form-row-last') {
                        return Container(
                          width: widthView,
                          alignment: AlignmentDirectional.topStart,
                          child: SizedBox(
                            width: (widthView - itemPaddingMedium) / 2,
                            child: child,
                          ),
                        );
                      }
                    }
                    return SizedBox(
                      width: (widthView - itemPaddingMedium) / 2,
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
