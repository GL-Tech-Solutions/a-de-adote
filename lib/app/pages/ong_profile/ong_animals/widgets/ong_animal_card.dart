import 'package:flutter/material.dart';

class OngAnimalCard extends StatelessWidget {
  final String? fotoUrl;
  final String nome;

  const OngAnimalCard({
    super.key,
    required this.fotoUrl,
    required this.nome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          fotoUrl == null
              ? const SizedBox()
              : Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(fotoUrl!).image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
          Text(nome),
        ],
      ),
    );
  }
}
