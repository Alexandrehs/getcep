import 'dart:async';

import 'package:dio/dio.dart';
import 'package:getcep/home/bloc/search_cep_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchCepBloc {
  final _searchController = StreamController<String>.broadcast();
  Sink<String> get searchCep => _searchController.sink;
  Stream<SearchCepState> get cepResult =>
      _searchController.stream.switchMap(_searchCep);

  Stream<SearchCepState> _searchCep(String cep) async* {
    yield SearchLoading();
    try {
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      yield SearchCepSucess(response.data);
    } catch (e) {
      yield SearchCepError('Não foi possivel buscar o Cep. $e');
    }
  }

  void dispose() {
    _searchController.close();
  }
}
