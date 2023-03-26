class PetModel {
  final String? id;
  final String nome;
  final String idadeAproximada;
  final String porte;
  final String especie;
  final String sexo;
  final bool castrado;
  final String? fotoUrl;
  final Map? vacinas;
  final String? descricao;

  PetModel({
    this.id,
    required this.nome,
    required this.idadeAproximada,
    required this.porte,
    required this.especie,
    required this.sexo,
    required this.castrado,
    this.fotoUrl,
    this.vacinas,
    this.descricao,
  });

  PetModel copyWith({
    String? id,
    String? nome,
    String? idadeAproximada,
    String? porte,
    String? especie,
    String? sexo,
    bool? castrado,
    String? fotoUrl,
    Map? vacinas,
    String? descricao,
  }) {
    return PetModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      idadeAproximada: idadeAproximada ?? this.idadeAproximada,
      porte: porte ?? this.porte,
      especie: especie ?? this.especie,
      sexo: sexo ?? this.sexo,
      castrado: castrado ?? this.castrado,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      vacinas: vacinas ?? this.vacinas,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'idadeAproximada': idadeAproximada,
      'porte': porte,
      'especie': especie,
      'sexo': sexo,
      'castrado': castrado,
      'fotoUrl': fotoUrl,
      'vacinas': vacinas,
      'descricao': descricao,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] as String,
      idadeAproximada: map['idadeAproximada'] as String,
      porte: map['porte'] as String,
      especie: map['especie'] as String,
      sexo: map['sexo'] as String,
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
    return 'PetModel(id: $id, nome: $nome, idadeAproximada: $idadeAproximada, porte: $porte, especie: $especie, sexo: $sexo, castrado: $castrado, fotoUrl: $fotoUrl, vacinas: $vacinas, descricao: $descricao)';
  }
}
