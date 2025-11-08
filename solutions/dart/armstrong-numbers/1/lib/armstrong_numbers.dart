final _values = {
  '0': BigInt.from(0),
  '1': BigInt.from(1),
  '2': BigInt.from(2),
  '3': BigInt.from(3),
  '4': BigInt.from(4),
  '5': BigInt.from(5),
  '6': BigInt.from(6),
  '7': BigInt.from(7),
  '8': BigInt.from(8),
  '9': BigInt.from(9)
};

final _zero = BigInt.from(0);

class ArmstrongNumbers {
  bool isArmstrongNumber(String number) {
    var sum = BigInt.from(0);
    int power = number.length;
    for (int i = number.length - 1; i >= 0; i--) {
      sum += (_values[number[i]] ?? _zero).pow(power);
    }
    return "${sum.toString()}" == number;
  }
}
