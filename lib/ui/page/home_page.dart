import 'package:flutter/material.dart';

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
          GridView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final ColorScheme colorScheme = Theme.of(context).colorScheme;
              final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
              final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/note-form');
                },
                child: Container(
                  alignment: Alignment.center,
                  // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: items[index].isOdd ? oddItemColor : evenItemColor,
                  ),
                  child: Text('Item $index'),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/note-form');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
