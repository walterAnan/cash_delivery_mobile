class Livraison {
  int id;
  String refOperation;
  String codeAgence;
  String nomClient;
  //String prenomClient;
  String telClient;
  String adresseLivraison;
  String nomBeneficiaire;
  //String prenomBeneficiaire;
  String telBeneficiaire;
  double montantLivraison;
  int nombreBillet10000;
  int nombreBillet5000;
  double fraisLivraison;
  String voucher;
  int commission;
  String lienGps;
  DateTime dateReception;
  //DateTime heureReception;
  DateTime dateLivraison;
 // DateTime heureLivraison;
  int livreurId;
  int agentLivreurId;
  String statutLivraison;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  Livraison(
      {this.id,
        this.refOperation,
        this.codeAgence,
        this.nomClient,
        //this.prenomClient,
        this.telClient,
        this.adresseLivraison,
        this.nomBeneficiaire,
        //this.prenomBeneficiaire,
        this.telBeneficiaire,
        this.montantLivraison,
        this.nombreBillet10000,
        this.nombreBillet5000,
        this.fraisLivraison,
        this.voucher,
        this.commission,
        this.lienGps,
        this.dateReception,
        //this.heureReception,
        this.dateLivraison,
        //this.heureLivraison,
        this.livreurId,
        this.agentLivreurId,
        this.statutLivraison,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  factory Livraison.fromJson(Map<String, dynamic> json) {
    return Livraison(
    id : json['id'],
    refOperation : json['ref_operation'],
    codeAgence : json['code_agence'],
    nomClient : json['nom_client'],
    //prenomClient : json['prenom_client'];
    telClient : json['tel_client'],
    adresseLivraison : json['adresse_livraison'],
    nomBeneficiaire : json['nom_beneficiaire'],
    //prenomBeneficiaire : json['prenom_beneficiaire'],
    telBeneficiaire : json['tel_beneficiaire'],
    montantLivraison : json['montant_livraison'],
    nombreBillet10000 : json['nombreBillet10000'],
    nombreBillet5000 : json['nombreBillet5000'],
    fraisLivraison : json['frais_livraison'],
    voucher : json['voucher'],
    commission : json['commission'],
    lienGps : json['lien_gps'],
    dateReception : json['date_reception'],
    //heureReception : json['heure_reception'],
    dateLivraison : json['date_livraison'],
    //heureLivraison : json['heure_livraison'],
    livreurId : json['livreur_id'],
    agentLivreurId : json['agent_livreur_id'],
    statutLivraison : json['statut_livraison'],
    userId : json['user_id'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    deletedAt : json['deleted_at']
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> Livraison = new Map<String, dynamic>();
  //   Livraison['id'] = this.id;
  //   Livraison['ref_operation'] = this.refOperation;
  //   Livraison['code_agence'] = this.codeAgence;
  //   Livraison['nom_client'] = this.nomClient;
  //   //data['prenom_client'] = this.prenomClient;
  //   Livraison['tel_client'] = this.telClient;
  //   Livraison['adresse_livraison'] = this.adresseLivraison;
  //   Livraison['nom_beneficiaire'] = this.nomBeneficiaire;
  //   //data['prenom_beneficiaire'] = this.prenomBeneficiaire;
  //   Livraison['tel_beneficiaire'] = this.telBeneficiaire;
  //   Livraison['montant_livraison'] = this.montantLivraison;
  //   Livraison['nombreBillet10000'] = this.nombreBillet10000;
  //   Livraison['nombreBillet5000'] = this.nombreBillet5000;
  //   Livraison['frais_livraison'] = this.fraisLivraison;
  //   Livraison['voucher'] = this.voucher;
  //   Livraison['commission'] = this.commission;
  //   Livraison['lien_gps'] = this.lienGps;
  //   Livraison['date_reception'] = this.dateReception;
  //   //data['heure_reception'] = this.heureReception;
  //   Livraison['date_livraison'] = this.dateLivraison;
  //   //data['heure_livraison'] = this.heureLivraison;
  //   Livraison['livreur_id'] = this.livreurId;
  //   Livraison['agent_livreur_id'] = this.agentLivreurId;
  //   Livraison['statut_livraison'] = this.statutLivraison;
  //   Livraison['user_id'] = this.userId;
  //   Livraison['created_at'] = this.createdAt;
  //   Livraison['updated_at'] = this.updatedAt;
  //   Livraison['deleted_at'] = this.deletedAt;
  //   return Livraison;
  // }
}