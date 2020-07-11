import 'package:flutter/material.dart';
import 'dart:math';

class TipPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> body;
  TipPage(
      {@required this.imagePath, @required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyWidgets = List();
    body.forEach((String text) {
      bodyWidgets.add(Text(text,
          style: TextStyle(fontSize: 16), textAlign: TextAlign.center));
      bodyWidgets.add(Padding(padding: EdgeInsets.only(top: 10)));
    });
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 50)),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(imagePath)))))),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(title,
              style: TextStyle(fontSize: 22), textAlign: TextAlign.center)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: bodyWidgets)),
      Padding(padding: EdgeInsets.only(top: 20)),
    ]);
  }
}

class Tips extends StatefulWidget {
  @override
  _Tips createState() => _Tips();
}

class _Tips extends State<Tips> {
  final PageController _controller = PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final _kArrowColor = Colors.black.withOpacity(0.8);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> _pages = <Widget>[
    TipPage(
      imagePath: "images/Pomodorro_rule.png",
      title: "The Pomodoro technique",
      body: [
        "Set up a 25-min timer to accomplish a single task - it should be well-defined and atomic. Do NOTHING else - no mail/phone check, no bio break, no coffee!",
        "Once the timer is out, you can loose your focus and take a well-deserved 5-min break."
      ],
    ),
    TipPage(
      imagePath: "images/2_min_rule.png",
      title: "The 2-minute rule",
      body: [
        "It can be hard to stick to a habit after the first days passed. Happily, committing 2 minutes per day isn’t so hard.",
        "This one is simple: do a given task for 2 minutes EVERY day - no exception. If you feel like doing more, great! But the key here is regularity."
      ],
    ),
    TipPage(
      imagePath: "images/chart.png",
      title: "The Pareto rule",
      body: [
        "You can do 80% of the result in 20% of the effort.",
        "The key is to identify the super-efficient tactics that make most of the result. The end is not perfect? Well, nothing is, so don’t sweat. If you absolutely need to get it exactly right, you can do the remaining 20% knowing that you’ve done most of the job already"
      ],
    ),
    TipPage(
      imagePath: "images/self_talk.png",
      title: "Self-Talk",
      body: [
        "This one can be very powerful in every aspect of your life. It shapes the way we react to the world - something totally in our control.",
        "Be optimistic and, above all, be your own friend - one that will effectively be forever with you. Be kind, patient, and loving."
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Tips"),
        backgroundColor: Colors.pink,
      ),
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Column(
          children: [
            Expanded(
                child: PageView(
              controller: _controller,
              children: _pages,
            )),
            SizedBox(
                height: 55,
                child: Container(
                  color: Colors.grey[800].withOpacity(0.5),
                  child: new Center(
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
