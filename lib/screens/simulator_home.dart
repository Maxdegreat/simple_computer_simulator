import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simulator/helpers/inputs.dart';

// Maximus Agubuzo

// 11 / 21 / 2022

// must have a map where it holds all possible instructions.
// using the given instructions map to an opperation pending on what is in
// AX. also show the next instruction address in PC

class SimulatorHome extends StatefulWidget {
  const SimulatorHome({Key? key}) : super(key: key);

  @override
  State<SimulatorHome> createState() => _SimulatorHomeState();
}

class _SimulatorHomeState extends State<SimulatorHome> {
  @override
  void initState() {
    generator();
    super.initState();
  }

  // this is the data vals to be updated below
  String AX = "";
  String PC = "";
  int output = 0;
  int counter = 0;
  int numberOfCycles = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("D Great Sim"),
      ),

      // The column should show the PC
      // the AX
      // the the opperations happening on AX
      // the current memory location
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [info()],
        ),
      ),
    );
  }

  Widget info() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
        ),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "AX: $AX",
              style: const TextStyle(color: Colors.white, fontSize: 21),
            ),

            Text(
              "PC: $PC",
              style: const TextStyle(color: Colors.white, fontSize: 21),
            ),

            Text(
              "Counter end value: $counter",
              style: const TextStyle(color: Colors.white, fontSize: 21),
            ),

            Text("Number of Cycles: $numberOfCycles",
                style: const TextStyle(color: Colors.white, fontSize: 21)),

            Text("Number of instructions: ${SimulatorInputs.mc1.length}",
              style: const TextStyle(color: Colors.white, fontSize: 21))
          ],
        ),
      ),
    );
  }

  // we will read in an input file
  // and search for certian mc. if we
  // see a mc that has meaning we will update
  // our code (like some conditional will be passed)

  generator() {
    // counter is init as 0
    int idx = 0;

    // using -1 on len bc we do not want to read the last
    // val since it just a stop.
    // also bc setting pc equal to next memory location
    for (int i = 0; i < SimulatorInputs.mc1.length - 1; i++) {
      var v = SimulatorInputs.mc1[i];

      setState(() {
        PC = SimulatorInputs.mc1[i + 1] != "0x00"
            ? SimulatorInputs.mc1[i + 1].substring(3, 9)
            : SimulatorInputs.mc1[i + 1];

        AX = SimulatorInputs.mc1[i];
      });
      // exit the for loop and prep to show
      // the output to the display
      if (v == "0x00") {
        log("made it to the end");
        break;
      }

      // now lets find the number of cycles
      getCycles(mc: v.substring(0, 4));

      // lets update the counter
      if (idx < SimulatorInputs.lst3.length) {
        counter += SimulatorInputs.lst3[idx];
        counter *= SimulatorInputs.lst3[idx];
        idx += 1;
      }
    }
  }

  getCycles({required String mc}) {
    // read mc and add value base on
    // instruction map
    if (SimulatorInputs.cyclesInfo[mc] != null) {
      numberOfCycles += SimulatorInputs.cyclesInfo[mc]!;
    } else {
      log("The val: {$mc} is not found in cycle info");
    }
  }
}
