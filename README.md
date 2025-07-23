# Logic
 knowledge rep and reasoning

 Most coding examples in ML involve algorithms written in Python and R. I was intrigued to see how predicate logic and proofs can also be used to in designing secure AI systems. e.g Autonomous vehicles verifying safety invariants.
A proof to the problem was drawn nested fraction-tree form (attached if you're able to make sense of my hand-writing), before testing in Lean4 via VSCode.
 
Best W
Saqib
 
Problem Statement: 
 
An autonomous vehicle's decision system must assess various logical criteria prior to determining crucial navigation choices. The system employs these propositions:
Significant traffic jam is identified on the regular path.
Alternative path has dangerous weather conditions.
Vehicle possesses sufficient fuel for the alternative path.
Vehicle reaches its intended location.
The system adheres to these intricate logical constraints:
When significant traffic is identified, the vehicle can reach its location only if the alternative path has favourable weather (¬) and sufficient fuel.
When the alternative path has dangerous weather, the vehicle must use the regular path, which necessitates absence of traffic (¬).
Supply a brief Lean proof establishing this logical relationship.
 
Proof:
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
 
Sandwich Ontology Report - Assignment Part 1
Overview of Ontology
This sandwich ontology provides a comprehensive conceptual framework for modelling various types of sandwiches and their constituent components or parts. The ontology encompasses 37 classes organised hierarchically to capture essential characteristics and relationships within the sandwich domain. More than 10 were used to try and encapsulate the bread of sandwich types mentioned in the Wikipedia link on sandwiches.
The ontology is constructed around two primary branches: sandwich types and ingredient categories. The classification system distinguishes between fundamental structural differences (open versus closed sandwiches) whilst accommodating cultural variations (Panini, Smorrebrod, Club sandwiches). The ingredient hierarchy systematically organises components from general categories (Bread, Filling, Condiment) to specific instances (Ham, Ciabatta, Cucumber).
Five object properties (containsBread, hasFilling, hasIngredient, isCompatibleWith, isLayeredAbove) establish the relational framework for expressing complex sandwich structures and ingredient interactions.
Justification of Hierarchical Relations
 
Primary Hierarchical Structure
The Sandwich → Closed_Sandwich/Open hierarchy reflects the structural difference in sandwich classification. Closed sandwiches (multiple bread pieces enclosing fillings) have different structural requirements than open sandwiches (single bread base with toppings), and hence requiring different logical constraints and preparation methods.
Ingredient Categorisation
The Ingredients → Bread/Filling/Condiment hierarchy organises components by functional role rather than material. Bread classes are distinguished by preparation method and cultural origin, whilst Filling subclasses (Meat, Vegetable, Cheese) are grouped by nutritional function and standard dietary requirements. Condiment division into Sauce and Spread reflects application methods.
Specialised Sandwich Types
Complex sandwiches such as ClubSandwich inherit from Double_Decker, which is a Closed_Sandwich because they maintain fundamental closed structure whilst adding specific layer requirements. Tripple_Decker, also a Closed_Sandwich represents further multi-layer construction and therefore a separate classification.
Property Classification
The following properties were used:
containsBread: needed to classify sandwich types
hasFilling: needed to define recipes
hasIngredients: capture other items which are not bread or filling
isCompatibleWith: required for culinary intelligence / cooking knowledge 
isLayeredAbove: know what’s inside but not how to build

Property	Functional	Inverse Functional	Transitive	Symmetric	Asymmetric	Reflexive	Irreflexive
containsBread					Y		Y
hasFilling					Y		Y
hasIngredient					Y		Y
isCompatibleWith						Y	
isLayeredAbove			Y		Y		Y

Examples of terminology
Symmetric: If bacon is compatible with lettuce, then lettuce is compatible with bacon
Asymmetric: If sandwich contains bread, then bread cannot contain sandwiches
Transitive: If lettuce is above tomato, and tomato is above bread, then lettuce us above bread
Reflexive: Every ingredient is compatible with itself 
Irreflective: A Sandwich cannot contain itself as a sandwich
Explanation of the Axiom
Primary Axiom: Double Decker Definition
Double_Decker ≡ Closed_Sandwich ⊓ (= 3 containsBread.Bread) ⊓ (= 2 hasFilling.Filling) 
Plain Language: A Double Decker sandwich contains exactly three bread pieces and 2 filling layers.
Advanced Axiom: ClubSandwich Specification
ClubSandwich ≡ Double_Decker ⊓ (= 1 hasFilling.Bacon) ⊓ (= 1 hasFilling.Chicken) ⊓ (= 1 hasFilling.Salad)
Plain Language: A Club sandwich is a double-decker containing exactly one each of bacon, chicken, and salad fillings.
Logical Justification
These axioms capture structural mathematics of multi-layer construction following the formula: filling layers = bread pieces - 1. For triple-deckers, four bread pieces create three filling spaces, while for double-deckers, three bread pieces create three filling spaces. Exact cardinality constraints prevent classification ambiguity whilst allowing precise automatic recognition.
The ClubSandwich axiom demonstrates constraint modelling by inheriting structural requirements from Double_Decker whilst specifying exact ingredient composition, supporting menu classification and dietary analysis applications.
Supporting Axioms
Double Decker: = 3 containsBread.Bread ⊓ ≥ 2 hasFilling.Filling
Open Sandwich: ≥ 1 containsBread.Bread
These establish consistent classification frameworks enabling automatic reasoning about sandwich types based on structural and compositional requirements.
Advantages and Disadvantages of This Starting Point
Advantages
1. Comprehensive Coverage Successfully captures sandwich types from simple (Open) to complex (Tripple_Decker), accommodating both Western varieties and international forms such as Smorrebrod, enabling cross-cultural reasoning.
2. Structural Precision Exact cardinality restrictions provide mathematical precision in definition, eliminating classification ambiguity and supporting clear automated reasoning.
3. Scalable Framework Hierarchical organisation allows straightforward extension for new sandwich types without disrupting existing structure; hence structures such as bread, condiment, filling (meat/veg) and open/closed sandwiches.
4. Recipe-Level Specificity Qualified number restrictions, exemplified by ClubSandwich definition, enable automatic recognition based on exact ingredient composition, supporting commercial applications.
Disadvantages
1. Over-Specification Risk Detailed categorisation may prove excessive for practical applications, potentially creating unnecessary complexity for simple identification tasks.
2. Cultural Bias Primarily reflects Western sandwich concepts, potentially inadequately representing non-Western bread-based foods or continuous bread forms common in other cultures. e.g. Pakistani roti, chapati, naan, paratha, tortillas etc
3. Preparation Method Limitations Focus on ingredients and structure largely ignores preparation methods (grilled, toasted, cold) which significantly affect sandwich classification.
4. Limited Dynamic Properties Lacks temporal properties for construction sequences, freshness constraints, or serving temperatures, limiting utility for food service applications.
5. Ingredient Interaction Gaps There are insufficient axioms to capture flavour profiles, dietary restrictions, or nutritional interactions influencing sandwich design decisions.

