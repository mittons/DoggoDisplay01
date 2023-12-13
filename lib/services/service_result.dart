class ServiceResult<T> {
  final T? data;
  final bool success;

  ServiceResult({required this.data, required this.success});
}
