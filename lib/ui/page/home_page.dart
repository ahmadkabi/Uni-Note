import 'package:flutter/material.dart';
import 'package:uninote/cubit/note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   final List<int> items = List<int>.generate(10, (int index) => index);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Stack(
        children: [
          items.isEmpty
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

          BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {

              if(state is NoteInitial){
                context.read<NoteCubit>().getNotes();
                return SizedBox();

              }else if(state is NotesSuccess){
                return GridView.builder(
                  itemCount: state.notes.length,
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final ColorScheme colorScheme = Theme.of(context).colorScheme;
                    final Color oddItemColor =
                    colorScheme.primary.withOpacity(0.05);
                    final Color evenItemColor =
                    colorScheme.primary.withOpacity(0.15);

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/note-form');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color:
                          items[index].isOdd ? oddItemColor : evenItemColor,
                        ),
                        child: Text('Item $index'),
                      ),
                    );
                  },
                );
              }else{
                return SizedBox();
              }

            },
          )
        ],
      ),
      floatingActionButton: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<NoteCubit>().insertNote(id: 2, title: "title");
              // Navigator.pushNamed(context, '/note-form');
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
