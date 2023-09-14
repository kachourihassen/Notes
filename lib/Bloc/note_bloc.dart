import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/model/note.dart';
import '/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository = NoteRepository();

  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      final notes = await _noteRepository.getNotes();
      emit(NotesLoaded(notes));
    });

    on<AddNote>((event, emit) async {
      if (event is AddNote) {
        await _noteRepository.insertNote(event.note);
        print('Note Added: ${event.note.title}, ${event.note.description}');
        final notes = await _noteRepository.getNotes();
        emit(NotesLoaded(notes));
      }
    });
  }

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
