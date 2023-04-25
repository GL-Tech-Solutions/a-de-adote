import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatefulWidget {
  final bool isOng;
  final String title;
  final Widget body;
  final EdgeInsets? bodyPadding;
  Function() edit;

  CustomExpansionTile({
    super.key,
    required this.isOng,
    required this.title,
    required this.body,
    required this.edit,
    this.bodyPadding,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with TickerProviderStateMixin {
  ValueNotifier<bool> isExpanded = ValueNotifier(true);
  late final AnimationController _controllerArrow;
  late final AnimationController _controllerBody;

  @override
  void initState() {
    super.initState();
    _controllerArrow = AnimationController(vsync: this, upperBound: 0.5);
    _controllerArrow.duration = const Duration(milliseconds: 200);

    _controllerBody = AnimationController(vsync: this);
    _controllerBody.duration = const Duration(milliseconds: 200);
  }

  @override
  void dispose() {
    isExpanded.dispose();
    _controllerArrow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.048,
          width: double.infinity,
          color: ProjectColors.secondaryDark,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: ProjectFonts.pLightBold,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isExpanded,
                      builder:
                          (BuildContext context, bool expanded, Widget? child) {
                        return IconButton(
                          iconSize: 22,
                          color: ProjectColors.light,
                          onPressed: () {
                            isExpanded.value = !isExpanded.value;
                            if (expanded) {
                              _controllerArrow.forward(from: 0.0);
                              _controllerBody.forward();
                            } else {
                              _controllerArrow.reverse(from: 0.5);
                              _controllerBody.reverse();
                            }
                          },
                          icon: RotationTransition(
                            turns: Tween(begin: 1.0, end: 0.0)
                                .animate(_controllerArrow),
                            child: const Icon(Icons.expand_less),
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: widget.isOng,
                      child: IconButton(
                        iconSize: 22,
                        color: ProjectColors.light,
                        onPressed: widget.edit,
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: isExpanded,
            builder: (BuildContext context, bool expanded, Widget? child) {
              return Visibility(
                visible: expanded,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, 0), end: const Offset(-1, 0))
                        .animate(
                      CurvedAnimation(
                        parent: _controllerBody,
                        curve: Curves.linear,
                      ),
                    ),
                    child: Padding(
                      padding: widget.bodyPadding ?? const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: widget.body,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
