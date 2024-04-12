import '../../core/status_requests/staus_request.dart';

StatusRequest foldFunction(final response) {
  return response.fold((left) => left, (rigth) => StatusRequest.sucess);
}
