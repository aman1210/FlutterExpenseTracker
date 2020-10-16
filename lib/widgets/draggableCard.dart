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
      duration: Duration(microseconds: 100),
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

  void openBottomSheet(var string, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Center(child: Text(string)),
        );
      },
    );
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
        _runAnimation();
        if (_alignment.x < -0.8) {
          openBottomSheet('expense', context);
        }
        if (_alignment.x > 0.8) {
          openBottomSheet('income', context);
        }
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
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                const BoxShadow(color: Color.fromRGBO(212, 200, 210, .7)),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: -5,
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.drag_indicator,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
