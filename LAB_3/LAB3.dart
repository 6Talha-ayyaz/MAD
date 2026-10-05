// lab3.dart - Campus Cafe Order System
// Name: ____________________   Roll no: ____________

const String rollNo = '04072313005'; // e.g. '2100672347'

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
class Dish {
  late String name;
  late int price;
}

class MenuItem {
  String name;
  int price;
  @override
  String toString() => '$name (Rs $price)';
  // Task 2.1 & 2.2: Initializing formal constructor with logic in body
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Task 3.1: Named constructor for giveaway items
  MenuItem.free(this.name) : price = 0;

  // Task 3.2: Named constructor using an initializer list to parse "Name:Price"
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);

  // Answer to Think question part-2:
  // 'price' cannot be declared final here because its value is reassigned
  // inside the constructor body (this.price = priceFloor) after the initial
  // field initialization. Final variables in Dart can only be assigned once
  // before the constructor body executes.

  // Answer to Think question part-3:
  // The floor logic did not run because in Dart, constructors do not
  // automatically share or chain execution bodies. MenuItem.free() initializes
  // the fields directly via its own initializer list and has no constructor
  // body. The floor adjustment exists exclusively inside the generative
  // default MenuItem(...) constructor's body.
}

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

  // Answer to Think question part-4:
  // In Dart, leading underscores make identifiers library-private.
  // If '_instance' and '_internal' were public (no underscore), external code
  // could bypass the singleton pattern by directly instantiating new objects via
  // OrderLog.internal() or reassigning/overwriting the shared OrderLog.instance.
}

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

  // Task 6.1: Getters
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';

  // Answer to Think question part-5:
  // An initializer list executes before the object is fully constructed and before
  // 'this' is bound or accessible. Since fields are initialized during this phase,
  // one field cannot reference another instance field (like reading 'total' to
  // compute 'tax') because the instance does not officially exist yet.

  // Answer to Think question part-6:
  // The line 'line.grand = 5;' fails because 'grand' is declared as a getter-only
  // property without a matching setter. To make it legal, a setter
  // 'set grand(int value) { ... }' would have to be defined in OrderLine.
}

class StudentCard {
  final String owner;
  int _balance; // private backing field

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  // Task 7.1: Setter clamping balance between 0 and balanceCap
  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }

  // Answer to Think question part-7:
  // Instead of silently clamping, a setter could throw an exception
  // (such as ArgumentError('Balance cannot be negative or exceed cap'))
  // to force the caller to handle the invalid assignment explicitly,
  // or assert the condition in debug mode via assert(v >= 0 && v <= balanceCap).
}

// Task 5.2: Top-level function returning a configured OrderLine
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

// Task 9.1: Build receipt with first three items from buildMenu()
List<OrderLine> buildReceipt() {
  final items = buildMenu();
  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  // Task 10.1: Main constructor with initializer list and assertion
  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50, 'percent must be between 1 and 50');

  // Factory constructor using cache
  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  // Method to compute discount
  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
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

  // Task 1.2: item1
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  // Task 1.2: item2
  var item2 = Dish();
  final int index2 = (u + 1) % 10;
  item2.name = menu[index2];
  item2.price = priceOf(index2);

  // Apply discount
  item2.price = item2.price - u;

  // Output formatting
  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');

  // Task 2.3: create a and b
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);

  // Print required format
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}

void step3() {
  print('--- Step 3 ---');

  // Task 3.3
  var freebie = MenuItem.free('Water');

  final int i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  // Required print statements
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');

  // Task 4.2
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

  // Check identity with identical()
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  print('--- Step 5 ---');

  // Task 5.3
  var line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0); // line = your mainOrder() result
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  print('--- Step 6 ---');

  // Task 6.2
  var line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

void step7() {
  print('--- Step 7 ---');

  // Task 7.2
  var card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand; // pay the main order
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');

  // Task 8.3: Call buildMenu()
  List<MenuItem> items = buildMenu();

  // Find most expensive item using reduce
  MenuItem priciest = items.reduce(
    (curr, next) => curr.price > next.price ? curr : next,
  );

  // Sum all 4 prices using fold
  int sum = items.fold(0, (total, item) => total + item.price);

  // Output formatting
  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');

  // Task 9.2: Call buildReceipt()
  final receipt = buildReceipt();
  int totalGrand = 0;

  for (final line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    OrderLog().add('receipt: ${line.label}');
    totalGrand += line.grand;
  }

  print('Step 9: receipt total = $totalGrand');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  print('--- Step 10 ---');

  // Task 10.2: 1 & 2
  final String code = 'CAFE${seed.toString().padLeft(2, '0')}';
  final c1 = Coupon.fromCode(code);
  final c2 = Coupon.fromCode(code);

  // 3. Add up grand over all lines of buildReceipt()
  final receiptLines = buildReceipt();
  final int receipt = receiptLines.fold(0, (sum, line) => sum + line.grand);

  // 4. Compute discount and print
  final int discount = c1.discountOn(receipt);

  print(
    'Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receipt, discount $discount, payable ${receipt - discount}',
  );
}



//ANSWER TO THE QUESTIONS
//Q1. Animal(this.name, this.type); and the verbose constructor give the same result.
// What does the shorthand save you?
//ANSWER: This constructor shorthand saves you from having to write out the assignments in the constructor body.
//It also helps to use final fields more easily, as they can be initialized directly in the constructor parameter list.
//Q2. When would you choose a named constructor, and when a factory constructor? 
//ANSWER: A named constructor is useful when you want to provide multiple ways to create an instance of a class, each with its own logic or parameters.
//A factory constructor is useful when you want to control the instance creation process, such as returning an existing instance (singleton pattern) or performing some caching or validation before creating a new instance.
//Q3. What is the difference between assigning a field in a constructor body and assigning it in an initializer list? 
//ANSWER: Assigning a field in a constructor body allows you to perform additional logic or validation before assigning the value, while assigning it in an initializer list is done before the constructor body executes and is typically used for final fields or when you want to ensure that the field is initialized before any other code runs in the constructor body.
//Q4. Give one reason to use a getter instead of storing the value in a field, and one reason to use a setter instead of a public field. 
//ANSWER: A getter can be used to compute a value on-the-fly based on other fields or logic, rather than storing it in a field, which can save memory and ensure the value is always up-to-date.
//A setter can be used to enforce validation or constraints on the value being assigned, preventing invalid states and encapsulating the logic for maintaining the integrity of the object's state.s