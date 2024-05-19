import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteFormPage extends StatelessWidget {
  const NoteFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Note Form'),
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                          hintText: 'Note',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                      minLines: 3,
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(colorScheme.primaryContainer),
                        foregroundColor: MaterialStateProperty.all(colorScheme.onPrimaryContainer), // Set the text color
                      ),
                      onPressed: () {},
                      child: const Text('Save'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
