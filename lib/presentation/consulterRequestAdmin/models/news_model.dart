class LeaveData {
  int id;
  int userId;
  String cause;
  DateTime dateDebut;
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
