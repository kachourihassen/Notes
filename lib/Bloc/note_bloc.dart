import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/model/note.dart';
import '/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository = NoteRepository();
/*
Ce code configure le gestionnaire d'événements pour l'événement LoadNotes. 
Lorsque cet événement est déclenché, il charge les notes à partir de la source de données et émet un état NotesLoaded avec les notes.
*/
  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    });
/*
Ce code configure le gestionnaire d'événements pour l'événement Add Note.
Lorsque cet événement est déclenché, il ajoute une nouvelle note à la source de données,
affiche un message de confirmation dans la console et émet un état NotesLoaded avec les notes mises à jour.
*/
    on<AddNote>((event, emit) async {
      if (event is AddNote) {
        await _noteRepository.insertNote(event.note);
        print('Note Added: ${event.note.title}, ${event.note.description}');
        final notes = await _noteRepository.getNotes();
        emit(NotesLoaded(notes));
      }
    });
  }
/*
Cette méthode convertit les événements en états en fonction de le logique métier. 
Si un événement AddNote est reçu, il insère une nouvelle note, puis émet un état NotesLoaded avec les notes mises à jour.
Si un événement LoadNotes est reçu, il charge les notes et émet un état NotesLoaded avec les notes.
 */
  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      await _noteRepository.insertNote(event.note);
      final notes = await _noteRepository.getNotes();
      yield NotesLoaded(notes);
    }
    if (event is LoadNotes) {
      final notes = await _noteRepository.getNotes();
      yield NotesLoaded(notes);
    }
  }
}
