import 'dart:io';

String fixture(String n) => File('test/helper/$n.json').readAsStringSync();
