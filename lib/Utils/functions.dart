import 'package:flutter/material.dart';

void showErrorToast(context, String message){
  final snackBar = SnackBar(content: Text('${message}'), backgroundColor: Colors.red);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessToast(context, String message){
  final snackBar = SnackBar(content: Text('${message}'), backgroundColor: Colors.green);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}