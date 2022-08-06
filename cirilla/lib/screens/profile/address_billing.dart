import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/address/country_address.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widgets/address_field_form3.dart';
import 'widgets/fields/loading_field_address.dart';

class AddressBookScreen extends StatefulWidget {
  static const String routeName = '/profile/address_billing';

  const AddressBookScreen({Key? key}) : super(key: key);

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> with SnackMixin, AppBarMixin {
  late AuthStore _authStore;
  late SettingStore _settingStore;
  AddressDataStore? _addressDataStore;
  late CustomerStore _customerStore;
  bool? _loading;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    _customerStore = CustomerStore(_settingStore.requestHelper)
      ..getCustomer(userId: _authStore.user!.id).then(
        (value) {
          String country =
              _customerStore.customer?.billing != null ? get(_customerStore.customer!.billing, ['country'], '') : '';
          _addressDataStore = AddressDataStore(_settingStore.requestHelper)
            ..getAddressData(queryParameters: {
              'country': country,
              'lang': _settingStore.locale,
            });
        },
      );
  }

  postAddress(Map data) async {
    try {
      setState(() {
        _loading = true;
      });
      TranslateType translate = AppLocalizations.of(context)!.translate;
      List<Map<String, dynamic>> meta = [];

      for (String key in data.keys) {
        if (key.contains('wooccm')) {
          meta.add({
            'key': 'billing_$key',
            'value': data[key],
          });
        }
      }

      await _customerStore.updateCustomer(
        userId: _authStore.user!.id,
        data: {
          'billing': data,
          'meta_data': meta,
        },
      );
      if (mounted) showSuccess(context, translate('address_billing_success'));
      setState(() {
        _loading = false;
      });
    } catch (e) {
      showError(context, e);
      setState(() {
        _loading = false;
      });
    }
  }

  Map<String, dynamic> getAddress(Customer? customer) {
    if (customer == null) {
      return {};
    }
    Map<String, dynamic> data = customer.billing ?? {};
    if (customer.metaData?.isNotEmpty == true) {
      for (var meta in customer.metaData!) {
        String keyElement = get(meta, ['key'], '');
        if (keyElement.contains('billing_wooccm')) {
          dynamic valueElement = meta['value'];
          String nameData = keyElement.replaceFirst('billing_', '');
          data[nameData] = valueElement;
        }
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Observer(
      builder: (_) {
        bool loadingAddressData = _addressDataStore?.loading ?? false;
        bool loadingCustomer = _customerStore.loading;
        Customer? customer = _customerStore.customer;
        bool loading = loadingAddressData || loadingCustomer;

        return Scaffold(
          appBar: baseStyleAppBar(context, title: translate('address_billing')),
          body: AddressChild(
            address: getAddress(customer),
            addressFields: _addressDataStore?.address?.billing ?? {},
            addressDataStore: !loading ? _addressDataStore : null,
            onSave: postAddress,
            loading: _loading,
            locale: _settingStore.locale,
            countryType: 'billing',
            countLoading: 10,
          ),
        );
      },
    );
  }
}

class AddressChild extends StatefulWidget {
  final Map<String, dynamic>? address;
  final Map<String, dynamic> addressFields;
  final AddressDataStore? addressDataStore;
  final Function(Map<String, dynamic> address) onSave;
  final bool? loading;
  final Widget? titleModal;
  final bool note;
  final bool borderFields;
  final String locale;
  final String countryType;
  final int countLoading;

  const AddressChild({
    Key? key,
    this.address,
    this.addressFields = const {},
    this.titleModal,
    this.borderFields = false,
    this.note = true,
    this.addressDataStore,
    required this.onSave,
    this.loading = false,
    this.locale = 'en',
    this.countryType = 'billing',
    this.countLoading = 8,
  }) : super(key: key);

  @override
  State<AddressChild> createState() => _AddressChildState();
}

class _AddressChildState extends State<AddressChild> with LoadingMixin {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};

  @override
  void didChangeDependencies() {
    if (widget.address != null) {
      setState(() {
        data = widget.address!;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AddressChild oldWidget) {
    if (oldWidget.address != widget.address && widget.address != data) {
      setState(() {
        data = widget.address ?? {};
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void changeValue(Map<String, dynamic> value) {
    setState(() {
      data = {
        ...data,
        ...value,
      };
    });
  }

  Widget buildForm() {
    List<CountryAddressData>? countries = widget.countryType == 'shipping'
        ? widget.addressDataStore!.address?.shippingCountries
        : widget.addressDataStore!.address?.billingCountries;
    Map<String, List<CountryAddressData>>? states = widget.countryType == 'shipping'
        ? widget.addressDataStore!.address?.shippingStates
        : widget.addressDataStore!.address?.billingStates;
    return AddressFieldForm3(
      formKey: _formKey,
      data: data,
      addressFields: widget.addressFields,
      onChanged: changeValue,
      countries: countries ?? [],
      states: states ?? {},
      titleModal: widget.titleModal,
      borderFields: widget.borderFields,
      onGetAddressData: (String country) {
        widget.addressDataStore!.getAddressData(queryParameters: {
          'country': country,
          'lang': widget.locale,
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return ListView(
      padding: const EdgeInsets.fromLTRB(layoutPadding, itemPaddingMedium, layoutPadding, itemPaddingLarge),
      children: [
        if (widget.addressDataStore != null) ...[
          buildForm(),
          if (widget.note == true) ...[
            const SizedBox(height: itemPaddingMedium),
            Text(translate('address_note'), style: theme.textTheme.caption),
          ],
          const SizedBox(height: itemPaddingLarge),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (widget.loading != true && _formKey.currentState!.validate()) {
                  widget.onSave(data);
                }
              },
              child: widget.loading == true
                  ? entryLoading(context, color: theme.colorScheme.onPrimary)
                  : Text(
                      widget.note == true ? translate('address_save') : translate('address_update'),
                    ),
            ),
          ),
        ] else
          LoadingFieldAddress(
            borderFields: widget.borderFields,
            count: widget.countLoading,
            titleModal: widget.titleModal,
          ),
      ],
    );
  }
}
