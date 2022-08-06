// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPostStore on SearchPostStoreBase, Store {
  Computed<ObservableList<String>>? _$dataComputed;

  @override
  ObservableList<String> get data =>
      (_$dataComputed ??= Computed<ObservableList<String>>(() => super.data, name: '_SearchPostStore.data')).value;
  Computed<int>? _$countComputed;

  @override
  int get count => (_$countComputed ??= Computed<int>(() => super.count, name: '_SearchPostStore.count')).value;

  final _$_dataAtom = Atom(name: '_SearchPostStore._data');

  @override
  ObservableList<String> get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(ObservableList<String> value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$addSearchAsyncAction = AsyncAction('_SearchPostStore.addSearch');

  @override
  Future<bool> addSearch(String value, {int? position}) {
    return _$addSearchAsyncAction.run(() => super.addSearch(value, position: position));
  }

  final _$removeSearchAsyncAction = AsyncAction('_SearchPostStore.removeSearch');

  @override
  Future<bool> removeSearch(String value) {
    return _$removeSearchAsyncAction.run(() => super.removeSearch(value));
  }

  final _$removeAllSearchAsyncAction = AsyncAction('_SearchPostStore.removeAllSearch');

  @override
  Future<bool> removeAllSearch() {
    return _$removeAllSearchAsyncAction.run(() => super.removeAllSearch());
  }

  @override
  String toString() {
    return '''
data: ${data},
count: ${count}
    ''';
  }
}
