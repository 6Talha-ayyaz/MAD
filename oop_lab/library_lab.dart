// library_lab.dart  -  Campus Library System
// Name: ____________________   Roll no: ____________

const String rollNo = '04072313005'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

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

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }
    renewals++;
    return true;
  }
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

abstract class LibraryItem {
  final String title;
  final int year;

  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int capFee(int fee) => fee > feeCap ? feeCap : fee;

  String describe() => '$title ($year)';

  int lateFee(int days);
}

List<LibraryItem> buildShelf() {
  final List<LibraryItem> shelf = [];
  for (int k = 0; k < shelfSize; k++) {
    final int i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }

  @override
  String describe() => '${super.describe()},$pages pages';

  @override
  int lateFee(int days) => days * feePerDay;
}
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue$issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()},$minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Magazine mainMagazine() {
  final int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

Dvd mainDvd() {
  final int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent ~/ 100);
}


extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials =>
      split(' ').map((w) => w.isNotEmpty ? w[0] : '').join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}


class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);

  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fine && runtimeType == other.runtimeType && amount == other.amount);

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}











void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}),${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

void step2() {
  print('--- Step 2 ---');
  
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}

void step3() {
  print('--- Step 3 ---');
  final book = mainBook();
  final mag = mainMagazine();
  final dvd = mainDvd();

  print('Step 3: Book late fee for $daysLate days =${book.lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days =${mag.lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days =${dvd.lateFee(daysLate)}');
}

void step4() {
  print('--- Step 4 ---');

  final book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  final List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (final item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
}
}

void step5() {
  print('--- Step 5 ---');

  final book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print('Step 5: renewed $ok of $renewAttempts attempts (limit$renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
}

void step6() {
  print('--- Step 6 ---');

  final memberType = MemberType.values[seed % 3];
  final book = mainBook();
  final fee = book.lateFee(daysLate);
  final discountedFee = memberType.applyDiscount(fee);

  print('Step 6: member type = ${memberType.name} (index ${memberType.index})');
  print('Step 6: max loans = ${memberType.maxLoans}');
  print('Step 6: book fee $fee -> $discountedFee after discount');
}

void step7() {
  print('--- Step 7 ---');

  final memberType = MemberType.values[seed % 3];
  final book = mainBook();
  final fee = book.lateFee(daysLate);
  final discountedFee = memberType.applyDiscount(fee);

  final List<LibraryItem> items = [mainBook(), mainMagazine(), mainDvd()];

  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print('Step 7: shelf fee for $daysLate days =${items.totalLateFee(daysLate).rs}');
}

void step8() {
  print('--- Step 8 ---');

  final f1 = Fine(mainBook().lateFee(daysLate));
  final f2 = Fine(mainMagazine().lateFee(daysLate));

  print('Step 8: $f1 + $f2 =${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
}

void step9() {
  print('--- Step 9 ---');

 LibraryItem.created = 0;
  buildShelf();
  final shelf = buildShelf();

  print('Step 9: items created = ${LibraryItem.created}');
  print('Step 9: capped fee = ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap$feeCap)');
  print('Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}');
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
}

void step10() {
  print('--- Step 10 ---');
}