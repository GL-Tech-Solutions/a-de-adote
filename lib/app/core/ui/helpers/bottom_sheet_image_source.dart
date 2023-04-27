import 'package:a_de_adote/app/core/constants/buttons.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin BottomSheetImageSource<T extends StatefulWidget> on State<T> {
  Future<ImageSource?> setImageSorce() async {
    ImageSource? source;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      source = ImageSource.camera;
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.photo_camera,
                      size: 50,
                      color: ProjectColors.primary,
                    ),
                  ),
                  const Text(
                    Buttons.camera,
                    style: ProjectFonts.pSecundaryDark,
                  )
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      source = ImageSource.gallery;
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.photo,
                      size: 50,
                      color: ProjectColors.primary,
                    ),
                  ),
                  const Text(
                    Buttons.galeria,
                    style: ProjectFonts.pSecundaryDark,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
    return source;
  }
}
