class SimulatorInputs {
  // each input will be a list of machine code. each input will be fead to
  // the simulator and the simulator will replicate the machine code.
  static const List<String> mc1 = [
    "0xA8 0x52", // load memory
    "0xB0 0x50", // add memory
    "0xA0 0x50", // store memory
    "0xA8 0x52", // load list
    "0xc0 0x50", // multiply memory
    "0xA0 0x50", // store memory
    "0xA8 0x01", // load memory
    "0xB0 0x01", // add (add one to ax and make it point to next ac value)
    "0xA0 0x01", // store new address back into location of arr for the next itr
    "0xA0 0x07", // store the new address in location for new loop
    "0xA8 0x51", // load remaining length of AC into the for loop itr
    "0xB8 0x01", // sub one from AC due to decrecing vals in the arr
    "0xA0 0x51", // store new vals of length for the arr
    "0xE8 0x00", // if still have vals jump to next location
    "0x00", // same as exit(-1) in c++
  ];
  // also a list of input list below as static.
  // this is the list that the above section will call along side the counter
  // var that is described in the simulator_home.dart file.

  static const List<int> lst1 = [1, 2, 3, 4, 5];
  static const List<int> lst2 = [19, 77, 993, 94];
  static const List<int> lst3 = [1, 2];

  static const Map<String, int> cyclesInfo = {
    // add
    "0xB0": 4,
    // load
    "0xA8": 6,
    // store
    "0xA0": 7,
    // sub
    "0xB8": 4,
    // mul
    "0xc0": 4,
    // if
    "0xE8": 4
  };
}
