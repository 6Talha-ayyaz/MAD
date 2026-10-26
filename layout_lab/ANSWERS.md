eam Board Lab Answers
Student Name: Talha Ayyaz

Roll Number: 04072313005

Numerical Answers
A1: 20
A2: 6
A3: 2
A4: 33

Conceptual Questions
B1: Which of your classes are Stateless and which are Stateful, and why?
StatefulWidget:

Clock: Needs a persistent Timer and mutable fields (_seconds, _builds) that update over time and trigger UI re-renders via setState().

Tile: Manages its own internal mutable tap counter (taps) independently of sibling tiles.

SwapBoard: Maintains an in-memory mutable list of tile widgets whose order changes dynamically when the swap action is executed.

StatelessWidget:

LabApp, HomePage, SettingsCard, Welcome, Probe, InfoPanel, SummaryRow, ShareRow, InfoBox, and StampStack.

None of these classes manage mutable internal state after creation; their layouts and visual configurations depend entirely on immutable constructor arguments or fixed global seed constants.

B2: Widget, Element, RenderObject: which one is rebuilt on every setState and which ones are kept? What did Probe show you?
On every setState(), the Widget is thrown away and rebuilt from scratch. The corresponding Element and RenderObject are preserved and updated in-place whenever the runtime type and key match.

Probe demonstrated this by printing identityHashCode: on every tick, identityHashCode(this) (the Widget instance) changed to a completely new number, whereas identityHashCode(context) (the Element instance) remained identical across every rebuild.

B3: Explain "constraints go down, sizes go up" using your Step 7 or Step 8 example.
In Step 7, an unconstrained Row passes unbounded width constraints (maxWidth: double.infinity) down to its direct children. Without tight constraints, each Text widget sized itself to fit on a single line, causing the combined width to exceed screen dimensions and triggering RenderFlex overflow errors.

Wrapping each Text inside an Expanded altered constraint propagation: the parent Row calculated the remaining screen width and passed down bounded, tight width constraints to each Expanded child. The Text widgets accepted those width limits from above, wrapped their words internally, and reported their measured sizes back up to the parent.