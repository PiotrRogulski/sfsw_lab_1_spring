import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:sfsw_lab_1_spring/layouts/layout_slot.dart';

class SlotDecoration extends StatelessWidget {
  const SlotDecoration({
    super.key,
    required this.child,
  });

  final LayoutSlot child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CustomBoxy(
        delegate: _SlotDecorationDelegate(),
        children: [
          BoxyId(
            id: #title,
            child: SizedBox(
              height: 32,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(child.title),
                ),
              ),
            ),
          ),
          BoxyId(
            id: #content,
            child: Card(
              elevation: 32,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotDecorationDelegate extends BoxyDelegate {
  BoxyChild get title => getChild(#title);
  BoxyChild get content => getChild(#content);

  @override
  Size layout() {
    final titleSize = title.layout(constraints.loosen());

    final contentSize = switch (constraints.hasBoundedHeight) {
      true => content.layout(
          constraints.deflate(
            EdgeInsets.only(
              top: titleSize.height,
            ),
          ),
        ),
      false => content.layout(
          constraints,
        ),
    };

    content.position(
      Offset(
        0,
        titleSize.height,
      ),
    );
    return Size(
      constraints.maxWidth,
      titleSize.height + contentSize.height,
    );
  }
}
