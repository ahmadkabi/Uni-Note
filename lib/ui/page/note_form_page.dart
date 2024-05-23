import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/note_cubit.dart';

class NoteFormPage extends StatelessWidget {
  final int? noteId;

  NoteFormPage(this.noteId, {super.key});

  final TextEditingController titleController = TextEditingController(text: '');
  final TextEditingController contentController = TextEditingController(text: '');

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
                      controller: titleController,
                    ),
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                          hintText: 'Note',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                      minLines: 3,
                      maxLines: null,
                      controller: contentController,
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
                    child: BlocBuilder<NoteCubit, NoteState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                colorScheme.primaryContainer),
                            foregroundColor: MaterialStateProperty.all(
                                colorScheme
                                    .onPrimaryContainer), // Set the text color
                          ),
                          onPressed: () {
                            context.read<NoteCubit>().insertNote(
                                  title: titleController.text,
                                  content: contentController.text,
                                );
                          },
                          child: const Text('Save'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
