import 'dart:convert';
import 'package:equatable/equatable.dart';

class OngModel extends Equatable {
  final String? id;
  final String cnpj;
  final String email;
  final String fantasia;
  final String nome;
  final String? telefone;
  final String? whatsapp;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String? complemento;
  final String municipio;
  final String uf;
  final String? fotoUrl;
  final String? informacoes;
  final Map? pix;

  const OngModel({
    this.id,
    required this.cnpj,
    required this.email,
    required this.fantasia,
    required this.nome,
    this.telefone,
    this.whatsapp,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    this.complemento,
    required this.municipio,
    required this.uf,
    this.fotoUrl,
    this.informacoes,
    this.pix,
  });

  OngModel copyWith({
    String? id,
    String? cnpj,
    String? email,
    String? fantasia,
    String? nome,
    String? telefone,
    String? whatsapp,
    String? cep,
    String? logradouro,
    String? numero,
    String? bairro,
    String? complemento,
    String? municipio,
    String? uf,
    String? fotoUrl,
    String? informacoes,
    Map? pix,
  }) {
    return OngModel(
      id: id ?? this.id,
      cnpj: cnpj ?? this.cnpj,
      email: email ?? this.email,
      fantasia: fantasia ?? this.fantasia,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      whatsapp: whatsapp ?? this.whatsapp,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      complemento: complemento ?? this.complemento,
      municipio: municipio ?? this.municipio,
      uf: uf ?? this.uf,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      informacoes: informacoes ?? this.informacoes,
      pix: pix ?? this.pix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cnpj': cnpj,
      'email': email,
      'fantasia': fantasia,
      'nome': nome,
      'telefone': telefone,
      'whatsapp': whatsapp,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'municipio': municipio,
      'uf': uf,
      'fotoUrl': fotoUrl,
      'informacoes': informacoes,
      'pix': pix,
    };
  }

  factory OngModel.fromMap(Map<String, dynamic> map) {
    return OngModel(
      id: map['id'] != null ? map['id'] as String : null,
      cnpj: map['cnpj'] as String,
      email: map['email'] as String,
      fantasia: map['fantasia'] as String,
      nome: map['nome'] as String,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      whatsapp: map['whatsapp'] != null ? map['whatsapp'] as String : null,
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      bairro: map['bairro'] as String,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      municipio: map['municipio'] as String,
      uf: map['uf'] as String,
      fotoUrl: map['fotoUrl'] != null ? map['fotoUrl'] as String : null,
      informacoes:
          map['informacoes'] != null ? map['informacoes'] as String : null,
      pix: map['pix'] != null ? map['pix'] as Map<String, dynamic> : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OngModel.fromJson(String source) =>
      OngModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OngModel(id: $id, cnpj: $cnpj, email: $email, fantasia: $fantasia, nome: $nome, telefone: $telefone, whatsapp: $whatsapp, cep: $cep, logradouro: $logradouro, numero: $numero, bairro: $bairro, complemento: $complemento, municipio: $municipio, uf: $uf, fotoUrl: $fotoUrl, informacoes: $informacoes, pix: $pix)';
  }

  @override
  List<Object?> get props => [
        id,
        cnpj,
        email,
        fantasia,
        nome,
        telefone,
        whatsapp,
        cep,
        logradouro,
        numero,
        bairro,
        complemento,
        municipio,
        uf,
        fotoUrl,
        informacoes,
        pix,
      ];
}
