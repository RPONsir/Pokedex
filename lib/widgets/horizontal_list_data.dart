import 'package:flutter/material.dart';

class HorizontalDataDisplay extends StatelessWidget{
  final List<dynamic> data;
  const HorizontalDataDisplay(this.data, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
            height: 70,
            width: 300,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GridView.count(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: data.length,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          children:
          List.generate(data.length, (index) {
            return Container(
              height: 20,
              color: Colors.white,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(10),
              child: Center(
                heightFactor: 1,
                child:  Text(
                  data[index].toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            );
          })
      ),
    );
  }
}