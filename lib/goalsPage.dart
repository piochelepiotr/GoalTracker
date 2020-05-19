import 'package:flutter/material.dart';
import 'createGoalPage.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> goalNames = new List<String>();
    goalNames.add("Eat icecream");
    goalNames.add("Weight 200 pounds");
    goalNames.add("Fly");
    goalNames.add("Have a lion as a pet");
    goalNames.add("Run for 10 feet without shoes");
    return Scaffold(
        appBar: AppBar(
            title: Text('My Goals'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: goalNames.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  child: Center(child: Text('${goalNames[index]}')),
              );
            }
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGoalPage()),
              );

            },
            label: Text('Add Goal'),
            backgroundColor: Colors.pink,
        ),
    );
  }
}
