enum RequestState { loading, success, error }

class RequestValue<T>{
  final T? result;
  final Object? error;
  final bool loading;
  final RequestState status;

  const RequestValue.loading()
    : result = null,
      error = null,
      loading = true,
      status = RequestState.loading;

  const RequestValue.success(this.result)
    : error = null,
      loading = false,
      status = RequestState.success;

  const RequestValue.error(this.error)
    : result = null,
      loading = false,
      status = RequestState.error;
}