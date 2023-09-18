part of 'note_bloc.dart';

/*
Ce code définit des classes d'états qui sont utilisées pour représenter l'état actuel du BLoC NoteBloc.
Chaque classe d'état peut avoir des propriétés spécifiques à l'état qu'elle représente,
et elles sont utilisées pour communiquer l'état de l'application à l'interface utilisateur ou à d'autres parties du code.
 */
abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NotesLoaded extends NoteState {
  final List<Note> notes;

  NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}
