import 'package:expenseTracker/widgets/dragContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  final Function cV;
  final bool visible;
  Home(this.cV, this.visible);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (widget.visible) {
          widget.cV(false);
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (!widget.visible)
          setState(() {
            widget.cV(true);
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return CustomScrollView(
      controller: _controller,
      shrinkWrap: true,
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: widget.visible ? size.height * 0.35 : 0,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/header2.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '\$20000',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        child: Container(
                          width: size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 150,
                                  width: 160,
                                ),
                              ),
                              Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 150,
                                  width: 160,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DragContainer(size),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
                Text('hello there'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
