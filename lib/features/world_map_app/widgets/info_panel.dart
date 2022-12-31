import 'package:flutter/material.dart';

class InfoPanel extends StatefulWidget {
  final Alignment alignment;
  final List<Widget> children;
  final Size size;
  const InfoPanel({
    super.key,
    required this.alignment,
    required this.children,
    this.size = const Size(300, 60),
  });

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontSize: 16);

    final verticalHide =
        widget.alignment == Alignment.topCenter || widget.alignment == Alignment.bottomCenter;

    return Align(
      alignment: widget.alignment,
      child: GestureDetector(
        onTap: () {
          print('dadsfsadf');
          setState(() {
            visible = !visible;
          });
        },
        child: Container(
          width: visible
              ? widget.size.width
              : verticalHide
                  ? widget.size.width
                  : 20,
          height: visible
              ? widget.size.height
              : verticalHide
                  ? 20
                  : widget.size.height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.only(
              topRight: widget.alignment == Alignment.centerLeft ||
                      widget.alignment == Alignment.bottomLeft ||
                      widget.alignment == Alignment.bottomCenter ||
                      widget.alignment == Alignment.center
                  ? const Radius.circular(20)
                  : Radius.zero,
              bottomRight: widget.alignment == Alignment.centerLeft ||
                      widget.alignment == Alignment.topLeft ||
                      widget.alignment == Alignment.topCenter ||
                      widget.alignment == Alignment.center
                  ? const Radius.circular(20)
                  : Radius.zero,
              topLeft: widget.alignment == Alignment.bottomCenter ||
                      widget.alignment == Alignment.bottomRight ||
                      widget.alignment == Alignment.centerRight ||
                      widget.alignment == Alignment.center
                  ? const Radius.circular(20)
                  : Radius.zero,
              bottomLeft: widget.alignment == Alignment.centerRight ||
                      widget.alignment == Alignment.topRight ||
                      widget.alignment == Alignment.topCenter ||
                      widget.alignment == Alignment.center
                  ? const Radius.circular(20)
                  : Radius.zero,
            ),
            color: Colors.black.withOpacity(0.15),
          ),
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle(
            style: style,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: visible ? widget.children : [],
            ),
          ),
        ),
      ),
    );
  }
}
