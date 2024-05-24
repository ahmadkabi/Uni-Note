import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/note_cubit.dart';
import '../../cubit/note_form_cubit.dart';

class NoteFormPage extends StatefulWidget {
  final int? noteId;

  NoteFormPage(this.noteId, {super.key});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final TextEditingController titleController = TextEditingController(text: '');
  final TextEditingController contentController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    context.read<NoteFormCubit>().getNoteById(widget.noteId);
  }

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
                child: BlocBuilder<NoteFormCubit, NoteFormState>(
                  builder: (context, state) {
                    if (state is NoteFormInitial) {
                      titleController.text = '';
                      contentController.text = '';
                    } else if (state is NoteFormSuccess) {
                      titleController.text = state.note.title;
                      contentController.text = state.note.content ?? '';
                    }

                    return Column(
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
                    );
                  },
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
                    child: BlocListener<NoteFormCubit, NoteFormState>(
                      child: Row(
                        children: [
                          if (widget.noteId != null) ...[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  context
                                      .read<NoteFormCubit>()
                                      .deleteNote(id: widget.noteId!);
                                },
                                child: const Text('Delete'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(colorScheme.background),
                                  foregroundColor: MaterialStateProperty.all(
                                      colorScheme.error),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: colorScheme.error)),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                          ],
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    colorScheme.primaryContainer),
                                foregroundColor: MaterialStateProperty.all(
                                    colorScheme.onPrimaryContainer),
                              ),
                              onPressed: () {
                                if (widget.noteId == null) {
                                  context.read<NoteFormCubit>().insertNote(
                                        title: titleController.text,
                                        content: contentController.text,
                                      );
                                } else {
                                  context.read<NoteFormCubit>().updateNote(
                                        id: widget.noteId!,
                                        title: titleController.text,
                                        content: contentController.text,
                                      );
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                      listener: (BuildContext context, NoteFormState state) {
                        if (state is NoteFormUpdateSuccess) {
                          Navigator.pop(context);
                          context.read<NotesCubit>().getNotes();
                        }
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
