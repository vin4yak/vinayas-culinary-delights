import 'package:flutter/material.dart';

@immutable
class PushMessage {

  final String title;
  final String body;

  const PushMessage({
    @required this.title,
    @required this.body,
  });

}
