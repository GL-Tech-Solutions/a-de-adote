// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:a_de_adote/app/core/rest_client/custom_dio.dart';
import 'package:a_de_adote/app/core/ui/widgets/dropdown_ong/dropdown_ong_widget.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository.dart';
import 'package:a_de_adote/app/repositories/ong/ong_repository_impl.dart';

import '../../../../services/auth_service.dart';
import 'dropdown_ong_controller.dart';

class DropdownOngRouter {
  final String value;
  final void Function(String?)? dropdownCallback;

  DropdownOngRouter({
    required this.value,
    required this.dropdownCallback,
  });

  Widget get page => MultiProvider(
        providers: [
          Provider<OngRepository>(
            create: ((context) => OngRepositoryImpl(
                  dio: context.read<CustomDio>(),
                  auth: context.read<AuthService>(),
                )),
          ),
          Provider<DropdownOngController>(
            create: ((context) => DropdownOngController(
                  context.read<OngRepository>(),
                )),
          ),
        ],
        child:
            DropdownOngWidget(value: value, dropdownCallback: dropdownCallback),
      );
}
