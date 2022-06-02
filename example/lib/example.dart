import 'package:http/http.dart';
import 'package:http_service1/http_service1.dart';

import 'model.dart';

Future<void> example() async {
  final HttpService service = HttpService(
    Client(),
    'https://jsonplaceholder.typicode.com/posts',
  );

  final res = await service.get<List<Model>>('', fromJson: modelFromJson);
  print(res);
  res.fold((l) => print, (r) => print);
}
