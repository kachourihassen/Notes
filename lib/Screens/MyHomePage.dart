import 'dart:math';
import 'package:digitrends/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/note_bloc.dart';

/* 
, cette page affiche une liste de notes avec des fonctionnalités de recherche par titre et d'ajout de nouvelles notes. 
Elle utilise le BLoC NoteBloc pour gérer les données des notes.
*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitrends Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Search by Title',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          BlocConsumer<NoteBloc, NoteState>(
            listener: (context, state) {
              if (state is NotesLoaded) {}
            },
            builder: (context, state) {
              if (state is NotesLoaded) {
                final filteredNotes = state.notes
                    .where((note) => note.title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      final randomColor =
                          Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                              .withOpacity(0.3);

                      return Card(
                        elevation: 4,
                        child: Container(
                          color: randomColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  note.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0.3,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  note.description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Note'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final title = titleController.text;
                      final description = descriptionController.text;
                      final note = Note(
                        title: title,
                        description: description,
                      );
                      if (titleController.text == "" ||
                          descriptionController.text == "") {
                        Navigator.of(context).pop();
                      } else {
                        noteBloc.add(AddNote(note));
                        Navigator.of(context).pop();
                      }
                      titleController.clear();
                      descriptionController.clear();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
