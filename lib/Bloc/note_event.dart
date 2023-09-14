part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends NoteEvent {
  final Note note;

  AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class LoadNotes extends NoteEvent {}
