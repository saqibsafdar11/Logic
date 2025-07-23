-- Student ID number: 201901718

--Summative 1 - KRR

-- PART 1
-- Scenario 1

/- DECISION - Interpret Rules as Alternative Paths (Not Conjunctive)
I will not use the interpretation that both conditions must be satisfied to conclude
z as can be implied from the english
terminology used in the problem statement.,as
the rules suggest otherwise; the problem states that we can conclude z if either x1
or x2 is true, and similarly for y1 or y2. -/


-- define the propositions and theorem
theorem SCENARIO_1 (x1 x2 y1 y2 z : Prop)
  -- the rules
  (rule1 : x1 → z)  -- if x1 is true, then z is true
  (rule2 : x2 → z)  -- if x2 is true, then z is true
  (_ : y1 → z)      -- rule 3: if y1 is true, then z is true (unused therefore marked with _)
  (_ : y2 → z)      -- rule 4: if y2 is true, then z is true (unused therefore marked with _)

  -- hypothesis - the given facts
  (h1 : x1 ∨ x2)    -- either x1 or x2 is true
  (_ : y1 ∨ y2)     -- h2: either y1 or y2 is true (unused threfore marked with _)
  : z :=            -- we need to show that z is true

  -- DECISION: Use Proof by Cases - with disjunction elimination
  -- as we have a disjunction h1 (x1 ∨ x2), we can use cases to analyze the two possibilities:
  -- We will use `Or.elim` to handle the disjunction h1 which takes a disjunction and two functions, one for each case of the disjunction.

  Or.elim h1
    (fun hx1 : x1 => rule1 hx1)  -- Case 1: if x1, then apply rule1
    (fun hx2 : x2 => rule2 hx2)  -- Case 2: if x2, then apply rule2
-- MP (Modus Ponens) is used here to apply the rules directly based on the hypotheses.
 -- since we have either x1 or x2, we can directly apply the corresponding rule to conclude z, regardless of y1 or y2.

 -- this completes the proof


-- Scenario 2:
/-
Propositions:
  a : Transaction from registered device
  b : Transaction amount exceeds typical spending pattern
  c : Location history is consistent
  d : Biometric verification passed
Rules:
  1. If amount exceeds typical (b), then biometric required (d)
  2. If unregistered device (¬a), then need location (c) AND biometric (d)
  3. At least one primary security: registered device (a) OR biometric (d)

Given: b (high amount) and ¬c (bad location)
Prove: a ∧ d (must have registered device AND biometric)

Given the following rules and facts, we want to prove that a ∧ d holds.

((b → d) ∧ (¬a → (c ∧ d)) ∧ ((a ∨ d) ∧ b ∧ ¬c)) → (a ∧ d)

-/

-- Define the propositions and theorem

theorem SCENARIO_2 (a b c d : Prop) :
  ((b → d) ∧ (¬a → (c ∧ d)) ∧ (a ∨ d) ∧ b ∧ ¬c) → (a ∧ d) :=
  fun h_all : (b → d) ∧ (¬a → (c ∧ d)) ∧ (a ∨ d) ∧ b ∧ ¬c => -- We will prove a ∧ d using the given rules and facts

    -- RULE1  b → d
    have rule1 : b → d := And.left h_all -- if the transaction b is high, then biometric d is required

    -- Extract the rest: (¬a → (c ∧ d)) ∧ (a ∨ d) ∧ b ∧ ¬c
    have h_rest1 : (¬a → (c ∧ d)) ∧ (a ∨ d) ∧ b ∧ ¬c := And.right h_all

    -- RULE 2  ¬a → (c ∧ d)
    have rule2 : ¬a → (c ∧ d) := And.left h_rest1 -- if the transaction is from an unregistered device ¬a, then we need location c and biometric d

    -- Extract the rest: (a ∨ d) ∧ b ∧ ¬c
    have h_rest2 : (a ∨ d) ∧ b ∧ ¬c := And.right h_rest1

    -- RULE 3  a ∨ d  - not used in the proof, so we can mark it with _
    have _ : a ∨ d := And.left h_rest2 -- rule 3: a ∨ d isnt used in the proof, so we can mark it with _

    -- Extract the rest: b ∧ ¬c
    have h_rest3 : b ∧ ¬c := And.right h_rest2

    -- Extract b (high transaction amount)
    have h_b : b := And.left h_rest3

    -- Extract ¬c (bad location history)
    have h_not_c : ¬c := And.right h_rest3

    -- First, we can prove d using rule1 and h_b
    have h_d : d := rule1 h_b  -- Applying modus ponens b → d to b to get d

    -- Now we can prove a by showing ¬a leads to contradiction

    have h_a : a :=
      Classical.byContradiction
        (fun h_not_a : ¬a =>
          -- If ¬a is true, we can apply rule2 to get c ∧ d
          -- This means we have an unregistered device, so we need location c and biometric d

          -- Apply rule2 with h_not_a to get c ∧ d
          have h_c_and_d : c ∧ d := rule2 h_not_a

          -- Extract c from the conjunction
          have h_c : c := And.left h_c_and_d

          -- We have c but also ¬c, which gives False
          h_not_c h_c)  -- Apply ¬c to c to get False

    -- Combine a and d into a ∧ d
    And.intro h_a h_d -- Using And.intro to combine a and d into a conjunction

-- This completes the proof, showing that given the rules and facts, we can conclude a ∧ d holds.


-- SCENARIO_3

/-
C: congestion
W: unsafe weather on alternative route
F: enough fuel on alternative route
D: car reaches destination

Define the propositions and theorem  -/

theorem SCENARIO_3 (C W F D : Prop)
  (h1 : C → (D → (¬W ∧ F)))  -- if there is congestion C, then if the car reaches destination D,
  --then it is not unsafe weather W and there is enough fuel F
  (_ : W → (D → ¬C)) -- if there is unsafe weather W, then if the car reaches destination D,
  --then there is no congestion C this rule is not used in the proof, so we can mark it with

/-
From h1 and h2, it can be concluded, that the car may not reach the destination D
if there is congestion C on the normal route and either unsafe weather W or not enough fuel F on the alternative route.
: (C ∧ (W ∨ ¬F)) → ¬D
-/

  : (C ∧ (W ∨ ¬F)) → ¬D := -- this is the conclusion we want to prove
  -- We will use proof by contradiction, assuming D and deriving a contradiction.
  fun rule1Conj : C ∧ (W ∨ ¬F) =>
    fun hD : D =>  -- To prove ¬D, lets assume D and derive False
      have hC : C := And.left rule1Conj -- Extract C from the conjunction
      have hDisj : W ∨ ¬F := And.right rule1Conj -- Extract W ∨ ¬F from the conjunction

      -- Apply h1 with C and D to get ¬W ∧ F
      have hDWF : ¬W ∧ F := h1 hC hD  -- Apply the rule h1 with C and D to obtain ¬W and F

      -- Now we have a conjunction ¬W ∧ F, we can extract ¬W and F
      have hNotW : ¬W := And.left hDWF -- Extract ¬W from the conjunction
      have hF : F := And.right hDWF -- Extract F from the conjunction

      -- Case analysis on W ∨ ¬F
      Or.elim hDisj
        (fun hW : W => hNotW hW)        -- Case 1: Assume W holds, but ¬W gives False
        (fun hNotF : ¬F => hNotF hF)    -- Case 2: Assume ¬F holds, but F gives False

-- In both cases, we derive a contradiction, hence we conclude ¬D.
      -- Therefore, we conclude that if C ∧ (W ∨ ¬F) holds, then D cannot hold.
      -- This completes the proof.


  -- Scenario 4



/-- propositional variables
t : A cybersecurity threat has been detected
r : Automatic response action is activated
f : The detected threat is confirmed as a false positive
m : Manual intervention by cybersecurity personnel is initiated
-/

theorem SCENARIO_4 (t r f m : Prop)
  (h : (t → r) ∧ (f → ¬r) ∧ (r → m) ∧ (¬m ∨ ¬f) ∧ t) :
  -- The theorem states that given the conditions, we can conclude r, m, and ¬f
  -- r is true, m is true, and f is false
  -- We will prove this by extracting the implications from the hypothesis and applying modus ponens and disjunction elimination.
  (r ∧ m ∧ ¬f) :=

  -- Extract all components from the nested conjunctions
  have threat_implies_response : t → r := And.left h
  have _ : f → ¬r := And.left (And.right h)
  have response_implies_manual : r → m := And.left (And.right (And.right h))
  have no_manual_or_not_false : ¬m ∨ ¬f := And.left (And.right (And.right (And.right h)))
  have threat_detected : t := And.right (And.right (And.right (And.right h)))

  -- Apply modus ponens to derive r and m
  have response_active : r := threat_implies_response threat_detected
  have manual_initiated : m := response_implies_manual response_active

  -- Derive ¬f using disjunction elimination
  let not_false_positive : ¬f :=
    Or.elim no_manual_or_not_false
      (fun no_manual : ¬m =>
        -- Case 1: ¬m, but we have m, so contradiction
        absurd manual_initiated no_manual)
      (fun not_false : ¬f =>
        -- Case 2: ¬f holds directly
        not_false)

  -- Combine all three conclusions
  And.intro response_active (And.intro manual_initiated not_false_positive)

-- This completes the proof for scenario 4, showing that given the conditions, we can conclude r, m, and ¬f.


-- PART 2
opaque conj : Prop -> Prop -> Prop -- opaque - Declares an undefined constant (we'll use axioms to describe its behavior).
-- conj: Represents logical conjunction (AND). It takes two propositions and returns a new proposition (e.g., conj x y means "x AND y").

opaque provable : Prop -> Prop  -- is a function that takes a proposition and returns a proposition

axiom AxConjElimRight : ∀ x y, provable (conj x y) -> provable y -- axiom for right elimination of conjunction
-- AxConjElimRight: If we can prove "conj x y", then we can prove y.

axiom AxConjElimLeft : ∀ x y, provable (conj x y) -> provable x
-- AxConjElimLeft: If we can prove "conj x y", then we can prove x.

axiom AxConjIntro : ∀ x y, provable x -> provable y -> provable (conj x y)
-- AxConjIntro: If we can prove x and we can prove y, then we can prove "conj x y".

axiom AxPrTrue   : provable True
-- AxPrTrue: True is provable, meaning we can always prove the truth of the proposition True.

axiom AxNotPrFalse : provable False -> False
-- AxNotPrFalse: If we can prove False, then we derive a contradiction (False).

-- Ex 1

theorem EX1 : ∀ x, ¬ provable (conj x False) ∧ (provable x -> ¬ provable False) :=
-- we will prove that for any proposition x, the conjunction "conj x False" is not provable, AND ∧ proving x does not lead to proving False.

  fun x =>  --  for any proposition x,
    And.intro -- we will construct a conjunction of two statements as we want to prove both parts of the AND ∧
   -- first part: ¬ provable (conj x False)
   -- lets assume that conj x False is provable - assumption [1]
      (fun h1 : provable (conj x False) =>
      -- from h1, we can derive that False is provable using right elimination of conjunction
        have pf : provable False := AxConjElimRight x False h1
        -- we can now use the axiom that provable False leads to a contradiction, as we have assumed that conj x False is provable
        AxNotPrFalse pf)
        -- therefore, we conclude that conj x False cannot be provable
        -- discharging assumption [1] we conclude that ¬ provable (conj x False) is true

    /- second part: provable x → ¬ provable False
   i.e. provable x → (provable False → False)
   lets assume that x is provable - assumption [2] -/
      (fun _ : provable x =>
      /- nb "_" is used to indicate that we are not using the value of provable x in the proof;
      as ¬ provable False is true regardles of the value of provable x

      now we need to prove  ¬ provable False
      assume we can prove False - assumption [3] -/
        fun h3: provable False =>
       -- if we can prove False, we get a contradiction, as
          AxNotPrFalse h3)
-- we can now discharge assumption [2]& [3] and conclude that provable x implies ¬ provable False
-- This completes the proof.

-- Ex 2

theorem EX2 : ∀ x y, provable (conj x False) -> provable y :=
/- we will prove that if we can prove the conjunction "conj x False",
then we can prove any proposition y.
-/

-- ∀I: introduce arbitrary x and y
fun x _ => --  y replaced by _ as it is not needed in the proof
-- lets assume that "conj x False" is provable - assumption [1]
    fun h : provable (conj x False) =>
/- we can apply the axiom for right elimination of conjunction;
using axiom AxConjElimRight : ∀ x y, provable (conj x y) -> provable y
from x and False, we can derive that False is provable -/
      have pf : provable False := AxConjElimRight x False h

-- axiom AxNotPrFalse : provable False -> False
      have contradiction : False := AxNotPrFalse pf

-- from False, we can derive anything, including provable y
      False.elim contradiction -- provable y

-- this completes the proof.


-- Ex 3

theorem EX3 : ∀ x y z, provable (conj x (conj y z)) -> provable (conj (conj y x) z) :=
/-
want to show: from x ∧ (y ∧ z), we can derive (y ∧ x) ∧ z for any propositions x, y, z.

-/
-- ∀I: introduce arbitrary x, y, z

  fun x y z =>
-- lets assume that "conj x (conj y z)" is provable - assumption [1]
    fun h : provable (conj x (conj y z)) =>
      -- we can apply the axiom for left elimination of conjunction;
      -- Extract x: using axiom AxConjElimLeft : ∀ x y, provable (conj x y) -> provable x
      have px : provable x := AxConjElimLeft x (conj y z) h
      -- Extract "conj y z": We can use using axiom AxConjElimRight : ∀ x y, provable (conj x y) -> provable y
      have pyz : provable (conj y z) := AxConjElimRight x (conj y z) h
      -- Extract y and z from "conj y z":
      -- Using AxConjElimLeft and AxConjElimRight again
      have py : provable y := AxConjElimLeft y z pyz
      -- Extract z from "conj y z":
      have pz : provable z := AxConjElimRight y z pyz
      /- Now we have px, py, and pz, we can now construct the desired conjunction "conj (conj y x) z"
      Using axiom AxConjIntro : ∀ x y, provable x -> provable y -> provable (conj x y)

      First, we construct "conj y x" from y and x -/
      have pyx : provable (conj y x) := AxConjIntro y x py px

      -- Finally, we can construct "conj (conj y x) z" using AxConjIntro again
      AxConjIntro (conj y x) z pyx pz

-- This completed the proof

-- Ex 4

theorem EX4 : ∀ x y : Prop,
  ¬ provable (conj x y) ->
  provable x ->
  ¬ provable y :=

  /- We will prove that if the conjunction "conj x y" is not provable, and x is provable,then y cannot be provable.

 ∀I: introduce arbitrary x and y  -/

  fun x y =>
-- lets assume that "conj x y" is not provable - assumption [1]
    fun h_not_conj : ¬ provable (conj x y) =>
-- lets assume that x is provable - assumption [2]
      fun h_px : provable x =>
/- lets assume that y is provable - assumption [3] - which is the opposite of what we want to prove
        -/
        fun h_py : provable y =>
        /- we will derive a contradiction from this assumption using
        AxConjIntro : ∀ x y, provable x -> provable y -> provable (conj x y) -/
          have h_conj : provable (conj x y) := AxConjIntro x y h_px h_py
          -- Now we have both h_not_conj and h_conj, which contradict each other
          h_not_conj h_conj
          /- This contradiction shows that our assumption (provable y) must be false
          Therefore, we conclude that ¬ provable y is true

          This completes the proof. -/
