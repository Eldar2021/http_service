import 'package:http_service/http_service.dart';
import 'package:http/http.dart';

import 'model.dart';

void main(List<String> arguments) async {
  final HttpService service = HttpService(
    Client(),
    'https://jsonplaceholder.typicode.com/posts',
  );

  final res = await service.get<List<Model>>('', fromJson: modelFromJson);
  print(res);
  res.fold((l) => print, (r) => print);
}
