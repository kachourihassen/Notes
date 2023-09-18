part of 'note_bloc.dart';

/*
 ce code définit des classes d'événements qui sont utilisées pour déclencher des actions spécifiques dans le BLoC NoteBloc.
Chaque classe d'événement hérite de la classe abstraite NoteEvent, 
et elles peuvent avoir des propriétés spécifiques à l'événement.
Les classes d'événements aident à structurer et à encapsuler la logique des actions que le BLoC doit effectuer en réponse à certaines
 interactions de l'utilisateur ou à d'autres événements.
 */
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
