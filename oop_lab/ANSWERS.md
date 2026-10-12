 Answer to Think question PART(1):
 `item.pages` causes a compile error because the static type of `item` is `LibraryItem`.
 Dart enforces static type safety at compile time based on the reference type, 
 and `LibraryItem` does not declare a `pages` field. Even though the object 
 on the heap is a `Book`, the compiler only permits access to members known to `LibraryItem`.