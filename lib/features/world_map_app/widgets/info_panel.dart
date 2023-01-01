import 'package:flutter/material.dart';

class InfoPanel extends StatefulWidget {
  final Alignment alignment;
  final List<Widget> children;
  final Size size;
  final double tabSize;
  final String title;
  const InfoPanel({
    super.key,
    required this.alignment,
    required this.children,
    this.size = const Size(300, 60),
    this.tabSize = 40,
    this.title = '',
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

    final leftHide = widget.alignment == Alignment.bottomLeft ||
        widget.alignment == Alignment.centerLeft ||
        widget.alignment == Alignment.topLeft;

    final topHide = widget.alignment == Alignment.topLeft ||
        widget.alignment == Alignment.topCenter ||
        widget.alignment == Alignment.topRight;

    return Align(
      alignment: widget.alignment,
      child: GestureDetector(
        onTap: () {
          setState(() {
            visible = !visible;
          });
        },
        child: Container(
          width: visible
              ? widget.size.width
              : verticalHide
                  ? widget.size.width
                  : widget.tabSize,
          height: visible
              ? widget.size.height
              : verticalHide
                  ? widget.tabSize
                  : widget.size.height,
          decoration: _createBoxDecoration(),
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle(
            style: style,
            child: verticalHide
                ? topHide
                    ? Column(
                        children: [
                          if (visible)
                            Expanded(
                              child: _createPanelData(),
                            ),
                          Text(widget.title),
                        ],
                      )
                    : Column(
                        children: [
                          Text(widget.title),
                          if (visible)
                            Expanded(
                              child: _createPanelData(),
                            ),
                        ],
                      )
                : leftHide
                    ? Row(
                        children: [
                          if (visible)
                            Expanded(
                              child: _createPanelData(),
                            ),
                          RotatedBox(
                            quarterTurns: verticalHide ? 0 : 3,
                            child: Text(widget.title),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          RotatedBox(
                            quarterTurns: verticalHide ? 0 : 3,
                            child: Text(widget.title),
                          ),
                          if (visible)
                            const SizedBox(
                              width: 20,
                            ),
                          if (visible)
                            Expanded(
                              child: _createPanelData(),
                            ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  Column _createPanelData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: widget.children,
    );
  }

  BoxDecoration _createBoxDecoration() {
    return BoxDecoration(
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
      color: Colors.blueGrey.withOpacity(0.4),
    );
  }
}
