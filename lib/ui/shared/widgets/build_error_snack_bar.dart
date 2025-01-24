import 'package:flutter/material.dart';

SnackBar buildErrorSnackBar(BuildContext context,String content){
  return SnackBar(
    backgroundColor: Theme.of(context).colorScheme.error,
    content: Text(content,style: TextStyle(
      color: Theme.of(context).colorScheme.onError
    ),)
  );
}