import 'dart:math';

import 'package:treachery_of_whales/treachery_of_whales.dart' as treachery_of_whales;
import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  ArgParser parser = ArgParser()..addOption('fileLocation', abbr: 'f');
  ArgResults argResults = parser.parse(arguments);
  final path = argResults['fileLocation'];
  final file = await File(path).readAsString();
  print(calculateFuel(parseData(file)));
}

Position calculateFuel(List<int> positions) {
  final minPosition = positions.reduce(min);
  final maxPosition = positions.reduce(max);

  List<Position> positionsList = [];

  for (int i = minPosition; i < maxPosition; i++) {
    var totalFuelCost = 0;
    for (final position in positions) {
      // fuel cost is equal to difference between current position and current position
      final fuelCost = calculateTriangle((position - i).abs());
      totalFuelCost += fuelCost;
    }
    positionsList.add(Position(totalFuelCost, i));
  }

  // Return the position with the lowest total fuel
  return positionsList.reduce((value, element) => value.totalFuel < element.totalFuel ? value : element);
}

int calculateTriangle(int difference) {
  if (difference == 0) {
    return difference;
  } else {
    return difference + calculateTriangle(difference - 1);
  }
}

List<int> parseData(String list) {
  return list.split(',').map((e) => int.parse(e)).toList();
}

class Position {
  Position(this.totalFuel, this.position);

  int totalFuel;
  int position;

  @override
  String toString() {
    return '{position: $position, totalFuel: $totalFuel}';
  }
}
