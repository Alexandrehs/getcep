abstract class SearchCepState {}

class SearchCepSucess implements SearchCepState {
  final Map data;

  SearchCepSucess(this.data);
}

class SearchCepError implements SearchCepState {
  final String message;

  SearchCepError(this.message);
}

class SearchLoading implements SearchCepState {}
