/*  
Cette classe Note est utilisée pour représenter une note dans l'application, avec des propriétés telles que l'identifiant,
le titre et la description.
Les méthodes toMap et factory Note.
fromMap permettent de convertir cette classe en un format de données (et inversement) qui peut être utilisé pour le stockage et la manipulation des notes dans l'application
*/

class Note {
  int? id;
  String title;
  String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
