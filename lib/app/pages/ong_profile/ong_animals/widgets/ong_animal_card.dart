import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OngAnimalCard extends StatefulWidget {
  final String? fotoUrl;
  final String nome;
  final String especie;
  Function() deleteMethod;

  OngAnimalCard(
      {super.key,
      required this.fotoUrl,
      required this.nome,
      required this.especie,
      required this.deleteMethod});

  @override
  State<OngAnimalCard> createState() => _OngAnimalCardState();
}

class _OngAnimalCardState extends State<OngAnimalCard> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    _isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.fotoUrl == null
                    ? const SizedBox(
                        height: 60,
                        width: 110,
                      )
                    : ValueListenableBuilder(
                        valueListenable: _isLoading,
                        builder: (BuildContext context, bool loading,
                            Widget? child) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              widget.fotoUrl!,
                              height: 60,
                              width: 110,
                              fit: BoxFit.fitWidth,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) {
                                  return child;
                                }
                                return AnimatedOpacity(
                                  opacity: loading ? 0 : 1,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeOut,
                                  child: child,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _isLoading.value = false;
                                  });
                                  return child;
                                }
                                return SizedBox(
                                  height: 60,
                                  width: 110,
                                  child: Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nome,
                      style: ProjectFonts.h6SecundaryDarkBold,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.especie == 'Cachorro'
                              ? MaterialCommunityIcons.dog
                              : widget.especie == 'Gato'
                                  ? MaterialCommunityIcons.cat
                                  : widget.especie == 'Pássaro'
                                      ? MaterialCommunityIcons.bird
                                      : widget.especie == 'Outro'
                                          ? MaterialCommunityIcons.paw
                                          : MaterialCommunityIcons.paw,
                          size: 14,
                          color: const Color(0xFF646464),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.especie,
                          style: ProjectFonts.smallSecundaryDark.copyWith(
                            color: const Color(0xFF646464),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.deleteMethod,
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 22,
                            color: ProjectColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
