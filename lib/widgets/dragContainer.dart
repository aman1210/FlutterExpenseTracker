import 'package:flutter/material.dart';
import 'package:expenseTracker/widgets/draggableCard.dart';

class DragContainer extends StatefulWidget {
  final Size size;
  DragContainer(this.size);

  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer>
    with SingleTickerProviderStateMixin {
  var containerWidth = 0.0;
  AnimationController _controller;
  Animation<double> _animation;
  void runAnimation() {
    _animation = _controller.drive(
      Tween(
        begin: 0.0,
        end: widget.size.width / 2 - 5,
      )..animate(
          CurvedAnimation(parent: _controller, curve: Curves.decelerate)),
    );
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    runAnimation();
    _controller.addListener(() {
      setState(() {
        containerWidth = _animation.value;
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
    var containerText = Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              ),
              Text(
                "Expense",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Income",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ],
    );

    var textHolder = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: containerWidth,
          height: 60,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              topLeft: Radius.circular(100),
            ),
          ),
        ),
        Container(
          height: 60,
          width: containerWidth,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          textHolder,
          containerText,
          DraggableCard(),
        ],
      ),
    );
  }
}
