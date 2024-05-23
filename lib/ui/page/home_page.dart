import 'package:flutter/material.dart';
import 'package:uninote/cubit/note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uninote/model/note_model.dart';
import 'package:uninote/ui/page/note_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    Widget noteCard(
      NoteModel note,
      bool isOdd,
    ) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: isOdd ? oddItemColor : evenItemColor,
        ),
        child: Text(
          note.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is NoteSuccess)
                state.notes.isEmpty
                    ? const SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note,
                              size: 50.0,
                              color: DefaultSelectionStyle.defaultColor,
                            ),
                            Text('Note is Empty'),
                          ],
                        ),
                      )
                    : const SizedBox(),
              if (state is NoteInitial)
                const SizedBox()
              else if (state is NoteSuccess)
                GridView.builder(
                  itemCount: state.notes.length,
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoteFormPage(state.notes[index].id),
                          ),
                        );
                      },
                      child: noteCard(
                        state.notes[index],
                        index.isOdd,
                      ),
                    );
                  },
                )
              else
                SizedBox(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteFormPage(null),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
