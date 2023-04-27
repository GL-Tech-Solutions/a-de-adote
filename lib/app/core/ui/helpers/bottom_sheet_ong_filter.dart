import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:flutter/material.dart';

import '../styles/project_colors.dart';
import '../styles/project_fonts.dart';
import '../widgets/dropdown_municipio_ong/dropdown_municipio_ong_router.dart';
import 'filters_state.dart';

mixin BottomSheetOngFilter<T extends StatefulWidget> on State<T> {
  final ValueNotifier<String?> _municipio = ValueNotifier('Todos');

  @override
  void dispose() {
    _municipio.dispose();
    super.dispose();
  }

  Future<Map?> setOngFilter(Map<String, dynamic>? currentFilters) async {
    Map<String, dynamic>? filters;

    if (currentFilters == null) {
      _municipio.value = 'Todos';
    } else {
      _municipio.value = currentFilters['municipio'];

      filters = currentFilters;
    }

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
                    Labels.filtro,
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
                      Buttons.fechar,
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
                        Labels.municipio,
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
                      onPressed: () {
                        _municipio.value = 'Todos';
                        filters = null;
                        FiltersState.ongCurrentFilters = null;
                        Navigator.of(context).pop();
                      },
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
                        Buttons.limparFiltro,
                        style: ProjectFonts.smallSecundaryDarkBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        filters = {
                          'municipio': _municipio.value,
                        };
                        FiltersState.ongCurrentFilters = filters;
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        Buttons.aplicar,
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

    return filters;
  }
}
