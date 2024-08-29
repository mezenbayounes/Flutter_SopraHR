class LeaveData {
  int id;
  int userId;
  String cause;
  DateTime dateDebut;
  DateTime created_at;
  String scDebut;
  DateTime dateFin;
  String scFin;
  String typeConge;
  String etat;
  String username;
  String image;
  String email;

  LeaveData({
    required this.id,
    required this.userId,
    required this.cause,
    required this.created_at,
    required this.dateDebut,
    required this.scDebut,
    required this.dateFin,
    required this.scFin,
    required this.typeConge,
    required this.etat,
    required this.username,
    required this.image,
    required this.email,
  });

  // Factory method to create a LeaveData instance from JSON
  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      id: json['id'],
      userId: json['user_id'],
      cause: json['cause'],
      created_at: DateTime.parse(json['created_at']),
      dateDebut: DateTime.parse(json['date_debut']),
      scDebut: json['sc_debut'],
      dateFin: DateTime.parse(json['date_fin']),
      scFin: json['sc_fin'],
      typeConge: json['type_conge'],
      etat: json['etat'],
      username: json['username'],
      image: json['image'],
      email: json['email'],
    );
  }
}

class RemoteData {
  int id;
  int userId;
  DateTime remoteDate;
  DateTime created_at;
  String etat;
  String username;
  String image;
  String email;

  RemoteData({
    required this.id,
    required this.userId,
    required this.remoteDate,
    required this.created_at,
    required this.etat,
    required this.username,
    required this.image,
    required this.email,
  });

  // Factory method to create a LeaveData instance from JSON
  factory RemoteData.fromJson(Map<String, dynamic> json) {
    return RemoteData(
      id: json['id'],
      userId: json['user_id'],
      remoteDate: DateTime.parse(json['date_remote']),
      created_at: DateTime.parse(json['created_at']),
      etat: json['etat'],
      username: json['username'],
      image: json['image'],
      email: json['email'],
    );
  }
}
