import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:mobx/mobx.dart';

part 'search_post_store.g.dart';

class SearchPostStore = SearchPostStoreBase with _$SearchPostStore;

abstract class SearchPostStoreBase with Store {
  final PersistHelper _persistHelper;

  @observable
  ObservableList<String> _data = ObservableList<String>.of([]);

  @computed
  ObservableList<String> get data => _data;

  @computed
  int get count => _data.length;

  // Action: -----------------------------------------------------------------------------------------------------------
  @action
  Future<bool> addSearch(String value, {int? position}) async {
    if (_data.isEmpty || _data.contains(value) != true) {
      position != null ? data.insert(position, value) : _data.add(value);
    }
    return await _persistHelper.saveSearchPost(_data);
  }

  @action
  Future<bool> removeSearch(String value) async {
    int index = _data.indexOf(value);
    _data.removeAt(index);
    return await _persistHelper.saveSearchPost(_data);
  }

  @action
  Future<bool> removeAllSearch() async {
    _data.clear();
    return await _persistHelper.saveSearchPost(_data);
  }

  // Constructor: ------------------------------------------------------------------------------------------------------
  SearchPostStoreBase(this._persistHelper) {
    init();
  }

  Future init() async {
    restore();
  }

  void restore() async {
    List<String>? data = await _persistHelper.getSearchPost();
    if (data != null && data.isNotEmpty) {
      _data = ObservableList<String>.of(data);
    }
  }
}
