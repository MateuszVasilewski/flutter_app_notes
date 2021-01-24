import 'package:flutter/material.dart';

final InputDecoration inputDecoration = InputDecoration(
  border: InputBorder.none,
  filled: true,
  fillColor: Colors.blue.withOpacity(0.1),
  labelStyle: const TextStyle(color: Colors.blue),
  contentPadding:
  const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
  labelText: "Add note here",
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.blue
      )
  ),
);