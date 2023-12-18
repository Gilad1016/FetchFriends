import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../models/dog_item.dart';
import 'dog_card.dart';
import 'edit_dog_card.dart';

class DogHero extends StatefulWidget {
  final DogItem dogItem;

  const DogHero({
    required this.dogItem,
    super.key,
  });

  @override
  _DogHeroState createState() => _DogHeroState();
}

class _DogHeroState extends State<DogHero> {
  late bool _showEditCard;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showEditCard = false;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.dogItem.id,
      child: _buildFlipAnimation(),
    );
  }

  void _toggleEditCard() {
    setState(() {
      // Use a temporary flag to avoid immediate toggle during animation
      _showEditCard = !_showEditCard;
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
        child: _showEditCard
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
        final isUnder = (ValueKey(_showEditCard) != widget?.key);
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
