import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  final tab = int.tryParse(Uri.base.queryParameters['tab'] ?? '0') ?? 0;
  final page = Uri.base.queryParameters['page'];
  runApp(HoaxCheckApp(initialIndex: tab, initialPage: page));
}