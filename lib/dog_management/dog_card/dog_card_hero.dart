import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../dog_management/dog_item.dart';
import 'view_dog_card.dart';
import 'edit_dog_card.dart';

class DogHero extends StatefulWidget {
  final DogItem dogItem;
  final bool isEditing;

  const DogHero({
    super.key,
    required this.dogItem,
    this.isEditing = false,
  });

  @override
  State<DogHero> createState() => _DogHeroState();
}

class _DogHeroState extends State<DogHero> {
  late bool _flipXAxis;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _flipXAxis = true;
    _isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    // _isEditing = widget.isEditing;

    return Hero(
      tag: widget.dogItem.id,
      child: _buildFlipAnimation(),
    );
  }

  void _toggleEditCard() {
    setState(() {
      // Use a temporary flag to avoid immediate toggle during animation
      _isEditing = !_isEditing;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _toggleEditCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) =>
            Stack(children: [widget ?? const Text("error"), ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _isEditing
            ? EditDogCard(
                dogItem: widget.dogItem,
                onEditCancel: _toggleEditCard,
              )
            : DogCard(
                dogItem: widget.dogItem,
                onEditPressed: _toggleEditCard,
              ),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_isEditing) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
