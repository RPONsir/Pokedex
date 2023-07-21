import 'package:flutter/material.dart';
import '../logic/api_data_logic.dart';

class HorizontalDataDisplay extends StatelessWidget{

  final PokemonDataFetchLogic typesLogic = PokemonDataFetchLogic();

  final List<dynamic> data;

  HorizontalDataDisplay(this.data, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,
      width: 300,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(0,0,0,10),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: GridView.count(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: data.length,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          children:
          List.generate(data.length, (index) {
            final Color typeColor = typesLogic.textToColor(data[index]);
            return Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: typeColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                heightFactor: 1.8,
                child:  Text(
                  data[index].toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          })
      ),
    );
  }
}