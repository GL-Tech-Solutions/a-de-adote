class PetModel {
  final String nome;
  final String idadeAproximada;
  final String porte;
  final String raca;
  final bool castrado;
  final String? fotoUrl;
  final Map? vacinas;
  final String? descricao;

  PetModel({
    required this.nome,
    required this.idadeAproximada,
    required this.porte,
    required this.raca,
    required this.castrado,
    this.fotoUrl,
    this.vacinas,
    this.descricao,
  });

  PetModel copyWith({
    String? nome,
    String? idadeAproximada,
    String? porte,
    String? raca,
    bool? castrado,
    String? fotoUrl,
    Map? vacinas,
    String? descricao,
  }) {
    return PetModel(
      nome: nome ?? this.nome,
      idadeAproximada: idadeAproximada ?? this.idadeAproximada,
      porte: porte ?? this.porte,
      raca: raca ?? this.raca,
      castrado: castrado ?? this.castrado,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      vacinas: vacinas ?? this.vacinas,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'idadeAproximada': idadeAproximada,
      'porte': porte,
      'raca': raca,
      'castrado': castrado,
      'fotoUrl': fotoUrl,
      'vacinas': vacinas,
      'descricao': descricao,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      nome: map['nome'] as String,
      idadeAproximada: map['idadeAproximada'] as String,
      porte: map['porte'] as String,
      raca: map['raca'] as String,
      castrado: map['castrado'] as bool,
      fotoUrl: map['fotoUrl'] != null ? map['fotoUrl'] as String : null,
      vacinas: map['vacinas'] != null
          ? map['vacinas'] as Map<String, dynamic>
          : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  @override
  String toString() {
    return 'PetModel(nome: $nome, idadeAproximada: $idadeAproximada, porte: $porte, raca: $raca, castrado: $castrado, fotoUrl: $fotoUrl, vacinas: $vacinas, descricao: $descricao)';
  }
}
