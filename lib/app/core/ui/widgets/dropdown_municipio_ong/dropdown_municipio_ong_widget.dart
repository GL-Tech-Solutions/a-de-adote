import 'package:a_de_adote/app/core/extensions/capitalize_only_first_letter_extension.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dropdown_ong/dropdown_ong_controller.dart';
import '../dropdown_ong/dropdown_ong_state.dart';

// ignore: must_be_immutable
class DropdownMunicipioOngWidget extends StatefulWidget {
  String value;
  final void Function(String?)? dropdownCallback;

  DropdownMunicipioOngWidget({
    super.key,
    required this.value,
    required this.dropdownCallback,
  });

  @override
  State<DropdownMunicipioOngWidget> createState() =>
      _DropdownMunicipioOngWidgetState();
}

class _DropdownMunicipioOngWidgetState
    extends State<DropdownMunicipioOngWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DropdownOngController>().dropdownLoadAllOngs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DropdownOngController, DropdownOngState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => _isLoading = false,
          initial: () => _isLoading = true,
          loading: () => _isLoading = true,
          error: () {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            );
          },
        );
      },
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => false,
        loading: () => true,
        loaded: () => true,
      ),
      builder: (context, state) {
        if (_isLoading) {
          return Container(
            height: 40,
            decoration: BoxDecoration(
              color: ProjectColors.lightDark,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(),
            ),
            child: const Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          List<Map> municipiosUf = state.listOngs
              .map((ong) => {
                    'nomeMunicipio': ong.municipio,
                    'uf': ong.uf,
                  })
              .toList();

          final municipios =
              municipiosUf.map((e) => e['nomeMunicipio']).toSet();
          municipiosUf.retainWhere(
            (Map x) {
              return municipios.remove(x['nomeMunicipio']);
            },
          );

          List<DropdownMenuItem<String>>? items = municipiosUf
              .map(
                (municipio) => DropdownMenuItem(
                  value: municipio['nomeMunicipio'].toString(),
                  child: Text(
                    '${municipio['nomeMunicipio'].toString().stringAdjusted} - ${municipio['uf'].toString()}',
                    style: ProjectFonts.smallSecundaryDark,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList();

          items.insert(
            0,
            const DropdownMenuItem(
              value: 'Todos',
              child: Text(
                'Todos',
                style: ProjectFonts.smallSecundaryDark,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );

          return DropdownButtonFormField<String>(
            isExpanded: true,
            items: items,
            value: widget.value,
            onChanged: widget.dropdownCallback,
            dropdownColor: ProjectColors.lightDark,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    const BorderSide(color: ProjectColors.secondaryDark),
              ),
              isCollapsed: true,
              filled: true,
              fillColor: ProjectColors.lightDark,
              contentPadding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            ),
          );
        }
      },
    );
  }
}
