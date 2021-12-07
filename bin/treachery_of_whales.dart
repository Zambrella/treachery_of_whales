import 'dart:math';

import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()..addOption('fileLocation', abbr: 'f');
  final argResults = parser.parse(arguments);
  print(calculateFuel(parseData(await File(argResults['fileLocation']).readAsString())));
}

Position calculateFuel(List<int> positions) {
  List<Position> positionsList = [];
  for (int i = positions.reduce(min); i < positions.reduce(max); i++) {
    var totalFuelCost = 0;
    for (final position in positions) {
      // fuel cost is equal to difference between current position and current position
      totalFuelCost += calculateTriangle((position - i).abs());
    }
    positionsList.add(Position(totalFuelCost, i));
  }
  // Return the position with the lowest total fuel
  return positionsList.reduce((value, element) => value.totalFuel < element.totalFuel ? value : element);
}

int calculateTriangle(int difference) {
  return difference == 0 ? difference : difference + calculateTriangle(difference - 1);
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
