import 'package:flutter/material.dart';

import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';
import '../widgets/dropdown_municipio_ong/dropdown_municipio_ong_router.dart';

mixin BottomSheetOngFilter<T extends StatefulWidget> on State<T> {
  final ValueNotifier<String?> _municipio = ValueNotifier('Todos');

  @override
  void dispose() {
    _municipio.dispose();
    super.dispose();
  }

  Future<Map?> setOngFilter() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtro',
                    style: ProjectFonts.h6SecundaryDarkBold,
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: ProjectColors.danger,
                    ),
                    label: Text(
                      'FECHAR',
                      style: ProjectFonts.smallLight
                          .copyWith(color: ProjectColors.danger),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Município',
                        style: ProjectFonts.smallSecundaryDarkBold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: _municipio,
                          builder: (BuildContext context, String? value,
                              Widget? child) {
                            return DropdownMunicipioOngRouter(
                              value: value!,
                              dropdownCallback: (selected) {
                                _municipio.value = selected;
                              },
                            ).page;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.light,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: ProjectColors.secondaryDark,
                          ),
                        ),
                      ),
                      child: const Text(
                        'LIMPAR FILTRO',
                        style: ProjectFonts.smallSecundaryDarkBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'APLICAR',
                        style: ProjectFonts.smallLightBold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
