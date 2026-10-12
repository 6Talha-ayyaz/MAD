 Answer to Think question PART(1):
 `item.pages` causes a compile error because the static type of `item` is `LibraryItem`.
 Dart enforces static type safety at compile time based on the reference type, 
 and `LibraryItem` does not declare a `pages` field. Even though the object 
 on the heap is a `Book`, the compiler only permits access to members known to `LibraryItem`.



 Answer to Think question PART(2):
 If you omit `@override` and mistype the name as `descibe()`, the compiler 
 treats it as a brand-new method rather than an override. When calling 
 `describe()` on an instance via a `LibraryItem` reference (or if `describe()` is called), 
 dynamic dispatch executes `LibraryItem.describe()`, returning only 
 "$title ($year)" without the subclass details (pages or issue).



 Answer to Think question PART(3):
 Instantiating an abstract class (`LibraryItem('x', 2000)`) causes a compile error:
 "Abstract classes can't be instantiated." 
 An abstract class represents an incomplete contract (e.g., `lateFee` has no body/implementation).
 Allowing direct instantiation would result in undefined behavior or runtime crashes 
 if an unimplemented method were invoked on that instance.