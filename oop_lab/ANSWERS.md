# OOP Lab - Answers

**Name:** Talha Ayyaz
**Roll Number:** 04072313005  

---

### Q1. What can a subclass using extends use for free that a class using implements has to write itself?
A subclass using `extends` automatically inherits concrete method implementations and state (instance variables) from the superclass for free. In contrast, a class using `implements` treats the target class as an interface only, inheriting zero implementation and requiring manual implementation of every member.

---

### Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?
Pick an abstract parent class when establishing a strict hierarchical "is-a" relationship that shares a core identity across all subclasses. Pick a mixin when sharing reusable behavior or state horizontally across unrelated or sibling classes without cluttering the primary inheritance tree.

---

### Q3. Why must you override hashCode whenever you override ==?
Hash-based collections such as `Set` and `Map` rely on `hashCode` to place objects into lookup buckets before invoking `==`. If two objects are considered equal by `==` but have different hash codes, they land in different buckets and the collection fails to recognize them as duplicates.

---

### Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?
In Dart, `String` is a final core class that cannot be subclassed or extended to protect runtime invariants and compiler optimizations. Extension methods do not alter the class hierarchy or memory layout; they resolve statically at compile time as syntactical wrappers around existing instances.