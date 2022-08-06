import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/brand/brand.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/utils/convert_data.dart';

abstract class ProductListMixin {
  /// Filter product on catalog screen
  bool productCatalog(product) {
    return product.catalogVisibility == 'visible' || product.catalogVisibility == 'catalog';
  }

  ProductCategory? getCategory(Map? args) {
    return get(args, ['category']) is ProductCategory
        ? get(args, ['category'])
        : ConvertData.stringToInt(get(args, ['id'])) > 0
            ? ProductCategory(
                id: ConvertData.stringToInt(get(args, ['id'])),
                name: get(args, ['name'], ''),
                categories: [],
              )
            : null;
  }

  Brand? getBrand(Map? args) {
    return get(args, ['brand']) is Brand ? get(args, ['brand']) : null;
  }
}
