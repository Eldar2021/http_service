
# http_service

<img width="325" alt="http+service" src="https://user-images.githubusercontent.com/64736636/173251293-80a62ec4-e559-4343-80e6-7fb338277567.png">

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

[license_link]: https://opensource.org/licenses/MIT

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg



### The goal of this package is to make it easy to implement the  `Http services` in a  `Dart` application.


# Installing

Add Get to your pubspec.yaml file:

```yaml
dependencies:
    http_service1:
```

Import get in files that it will be used:

```dart
import 'package:http_service1/http_service1.dart';
```

## Exceptions

### Auhtentication Exception
* `Auhtentication Exception` is thrown when an authentication error occurs while accessing the naming or directory service. 

### Convert Exception
* `Converter Exception` is an exception to indicate that the requested conversion cannot be performed.

### Server Exception
* The `server exception` is used when there will be problems with receiving any response packets from the server.

## Example

```dart
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
```
#### model.dart
```dart
import 'dart:convert';

List<Model> modelFromJson(String str) => List<Model>.from(
      json.decode(str).map((x) => Model.fromJson(x)),
    );

String modelToJson(List<Model> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class Model {
  Model({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  String toString() {
    return title;
  }
}
```

## Contributing

