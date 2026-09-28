final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming']
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile']
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design']
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math']
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile']
  },
];

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();

  await part6();
}

//===========================
// PART 1
//===========================

void part1() {
  print('--- Part 1 ---');

  double lateFee(int daysLate, double ratePerDay) =>
      daysLate * ratePerDay;

  double fee = lateFee(2, 3.0);
  print(fee);

  String formatTitle(String title, [String? author]) {
    if (author == null) {
      return title;
    } else {
      return '$title by $author';
    }
  }

  String format = formatTitle("c++", "Abubakar");
  print(format);

  Map<String, dynamic> makeBook({
    required String title,
    required String author,
    int year = 2024,
    int copies = 1,
  }) {
    return {
      'title': title,
      'author': author,
      'year': year,
      'copies': copies,
    };
  }

  var newBook = makeBook(
    title: 'Java Basics',
    author: 'Ali',
  );

  print(newBook);

  bool isClassic(int year) => year > 2000;

  print(isClassic(2001));
}

//===========================
// PART 2
//===========================

void part2() {
  print('--- Part 2 ---');

  List<String> transformAll(
    List<String> items,
    String Function(String) fn,
  ) {
    return items.map(fn).toList();
  }

  int Function() makeCounter() {
    int count = 0;

    return () {
      count++;
      return count;
    };
  }

  double Function(int) makeFeeCalculator(double rate) {
    return (int days) {
      return days * rate;
    };
  }

  int sumDigits(int n) {
    if (n < 10) {
      return n;
    }

    return n % 10 + sumDigits(n ~/ 10);
  }

  var titles = [
    'Dart in Action',
    'Clean Code',
  ];

  var upperCaseTitles = transformAll(
    titles,
    (String item) {
      return item.toUpperCase();
    },
  );

  print(upperCaseTitles);

  var exclamationTitles = transformAll(
    titles,
    (item) => '$item!',
  );

  print(exclamationTitles);

  var desk1 = makeCounter();
  var desk2 = makeCounter();

  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);

  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(125)}');
}

//===========================
// PART 3
//===========================

Map<String, int> buildStock() {
  return {
    for (var book in books)
      book['title'] as String: book['copies'] as int
  };
}

void part3() {
  print('--- Part 3 ---');

  var titles = books
      .map(
        (book) => book['title'] as String,
      )
      .toList();

  print('Titles: $titles');

  var available = books
      .where(
        (book) => (book['copies'] as int) > 0,
      )
      .map(
        (book) => book['title'] as String,
      )
      .toList();

  print('Available: $available');

  var totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );

  print('Total copies: $totalCopies');

  var years = books
      .map(
        (book) => book['year'] as int,
      )
      .toList();

  var oldestYear = years.reduce(
    (a, b) => a < b ? a : b,
  );

  print('Oldest year: $oldestYear');

  var sortedBooks = List<Map<String, dynamic>>.of(books);

  sortedBooks.sort(
    (a, b) =>
        (a['year'] as int).compareTo(b['year'] as int),
  );

  var sortedTitles = sortedBooks
      .map(
        (book) => book['title'] as String,
      )
      .toList();

  print('By year: $sortedTitles');

  var stock = buildStock();

  print('Stock: $stock');

  stock.forEach(
    (title, copies) {
      if (copies == 0) {
        print('Out of stock: $title');
      }
    },
  );

  print(
    'Copies of Unknown: ${stock['Unknown'] ?? 0}',
  );

  Set<String> allTags = {
    for (var book in books)
      ...(book['tags'] as List<String>)
  };

  print('All tags: $allTags');

  var a = {
    'Dart in Action',
    'Clean Code',
    'Flutter Basics'
  };

  var b = {
    'Clean Code',
    'Flutter Basics',
    'Algorithms'
  };

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

//===========================
// PART 4
//===========================

class Box<T> {
  T value;

  Box(this.value);
}

T firstOr<T>(
  List<T> items,
  T fallback,
) {
  if (items.isEmpty) {
    return fallback;
  }

  return items.first;
}

class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}

void part4() {
  print('--- Part 4 ---');

  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  print(
    firstOr(
      ['Dart in Action', 'Clean Code'],
      'none',
    ),
  );

  print(
    firstOr<String>(
      [],
      'z',
    ),
  );

  print(
    Pair(
      'Dart in Action',
      3,
    ),
  );
}

//===========================
// PART 5
//===========================

class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}

void part5() {
  print('--- Part 5 ---');

  void checkOut(
    Map<String, int> stock,
    String title,
  ) {
    if (!stock.containsKey(title)) {
      throw BookNotFoundException(title);
    }

    if (stock[title]! <= 0) {
      throw BookNotAvailableException(title);
    }

    stock[title] = stock[title]! - 1;
  }

  Map<String, dynamic> findBook(String title) {
    return books.firstWhere(
      (book) => book['title'] == title,
    );
  }

  var stock = buildStock();

  var titles = [
    'Dart in Action',
    'Flutter Basics',
    'Unknown Book',
  ];

  for (var title in titles) {
    try {
      checkOut(stock, title);

      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print(
        'Sorry: "${e.title}" has no copies left',
      );
    } on BookNotFoundException catch (e) {
      print(
        'Not found: "${e.title}"',
      );
    } finally {
      print('Transaction logged.');
    }
  }

  print(
    'Copies left of Dart in Action: ${stock['Dart in Action']}',
  );

  try {
    findBook('Missing');
  } on StateError {
    print(
      'Search failed: no such book',
    );
  }
}

//===========================
// PART 6
//===========================

Future<String> fetchBookOfTheDay() async {
  await Future.delayed(
    Duration(seconds: 1),
  );

  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(
    Duration(milliseconds: 500),
  );

  throw Exception('Server down');
}

Future<void> part6() async {
  print('--- Part 6 ---');

  print('Fetching...');

  var result = await fetchBookOfTheDay();

  print(
    'Book of the day: $result',
  );

  try {
    await fetchBroken();
  } catch (e) {
    print(
      'Fetch failed: $e',
    );
  }
}



// 1. When would you choose fold over reduce?
//When the list might be empty we use fold
//reduce requires atleast 1 item inside a list

// 2. What does it mean that a closure "captures" a variable?
// It means the returned function remembers a variable from its outer function.
// In makeCounter, the variable count is captured.

// 3. Why must on BookNotAvailableException come before a general catch (e)?
//catch catches almost every exception, so if it comes first,
// the bookNotAvailableException handler would never run.

// 4. Why does forgetting await still compile, but give the wrong result?
// Because an async function returns a Future object.
// Without await, we print  the value without waiting for the
//function to return a value that will Give us wrong value