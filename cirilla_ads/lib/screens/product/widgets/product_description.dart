import 'package:flutter/material.dart';

import 'package:feather_icons/feather_icons.dart';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';

class ProductDescription extends StatelessWidget with TransitionMixin {
  final Product? product;
  final bool? expand;
  final String? align;

  const ProductDescription({Key? key, this.product, this.expand, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    if (expand!) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              translate('product_description'),
              textAlign: ConvertData.toTextAlign(align),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          buildContent(description: product?.description),
        ],
      );
    }
    return CirillaTile(
      title: Text(translate('product_description'), style: theme.textTheme.subtitle2),
      isDivider: false,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => ProductDescriptionModal(
              description: product?.description,
              content: buildContent(description: product?.description),
            ),
            transitionsBuilder: slideTransition,
          ),
        );
      },
    );
  }

  buildContent({String? description}) {
    return CirillaHtml(html: description ?? '');
  }
}

class ProductDescriptionModal extends StatelessWidget with AppBarMixin, TransitionMixin {
  final String? description;
  final Widget? content;

  const ProductDescriptionModal({Key? key, this.description, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(translate('product_description'), style: Theme.of(context).textTheme.subtitle1),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              FeatherIcons.x,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: paddingHorizontal.copyWith(bottom: layoutPadding),
        children: [content!],
      ),
    );
  }
}
