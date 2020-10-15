import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Alignment _alignment = Alignment.center;

  Animation<Alignment> _animation;

  void _runAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _alignment,
        end: Alignment.center,
      ),
    );
    _controller.reset();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.addListener(() {
      setState(() {
        _alignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _alignment += Alignment(details.delta.dx / (size.width / 2), 0);
        });
      },
      onPanEnd: (details) {
        print(_alignment.x);
        _runAnimation();
      },
      child: Align(
        alignment: _alignment,
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(boxShadow: [
              const BoxShadow(color: Color.fromRGBO(212, 200, 210, .7)),
              const BoxShadow(
                color: Colors.white,
                spreadRadius: -5,
                blurRadius: 10,
              ),
            ], borderRadius: BorderRadius.circular(60)),
          ),
        ),
      ),
    );
  }
}
