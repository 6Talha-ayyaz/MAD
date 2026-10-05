// lab3.dart - Campus Cafe Order System
// Name: Talha Ayyaz   Roll no: 04072313005

const String rollNo = '04072313005';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

// --- Step 1 Class ---
class Dish {
  late String name;
  late int price;
}

// --- Steps 2 & 3 Class ---
class MenuItem {
  String name;
  int price;

  // Task 2.1 & 2.2: Initializing formal constructor with logic in body
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Task 3.1: Named constructor for giveaway items
  MenuItem.free(this.name) : price = 0;

  // Task 3.2: Named constructor using an initializer list
  MenuItem.fromString(String text)
      : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);

  // Think Step 2:
  // 'price' cannot be declared final here because its value is reassigned
  // inside the constructor body (this.price = priceFloor) after the initial
  // field initialization. Final variables in Dart can only be assigned once.

  // Think Step 3:
  // The floor logic did not run because in Dart, constructors do not
  // automatically share or chain execution bodies. MenuItem.free() initializes
  // the fields directly via its own initializer list and has no constructor body.
}

// --- Step 4 Class ---
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal(); // private named constructor

  // Task 4.1: Factory constructor returning the singleton instance
  factory OrderLog() {
    _instance ??= OrderLog._internal();
    return _instance!;
  }

  void add(String msg) => entries.add(msg);

  // Think Step 4:
  // In Dart, leading underscores make identifiers library-private.
  // If '_instance' and '_internal' were public, external code could bypass
  // the singleton pattern by directly calling the constructor or overwriting the instance.
}

// --- Step 5 Class ---
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  // Task 5.1: Initializer list computing total, tax, and asserting qty > 0
  OrderLine(this.item, this.qty)
      : total = item.price * qty,
        tax = (item.price * qty) * taxPercent ~/ 100,
        assert(qty > 0, 'qty must be positive');

  // Think Step 5:
  // An initializer list executes before the object is fully constructed and before
  // 'this' is bound or accessible. Since fields are initialized during this phase,
  // one field cannot reference another instance field (like reading 'total' to
  // compute 'tax') because the instance does not officially exist yet.
}

// Task 5.2: Top-level function returning a configured OrderLine
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();
  final int index2 = (u + 1) % 10;
  item2.name = menu[index2];
  item2.price = priceOf(index2);
  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');
  final int i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    final String msg = 'order #${100 * t + i}';
    if (i % 2 != 0) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}