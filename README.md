# Logic and Knowledge Representation

Application of formal logic and knowledge representation techniques in AI systems, featuring autonomous vehicle safety verification and ontological modeling.

## 📋 Overview

This repository demonstrates how predicate logic, formal proofs, and ontologies can be used beyond traditional ML algorithms to create verifiable and reasoning-capable systems. The project includes:

- **Autonomous Vehicle Safety**: Formal verification of navigation decision logic using Lean4
- **Sandwich Ontology**: Comprehensive knowledge representation framework with modal logic constraints

## 🚗 Project 1: Autonomous Vehicle Safety Verification

Formal proof system for verifying safety invariants in autonomous vehicle navigation decisions.

### Problem Definition

```
Propositions:
- C: Congestion on regular route
- W: Unsafe weather on alternative route  
- F: Enough fuel for alternative route
- D: Car reaches destination

Constraints:
- C → (D → (¬W ∧ F))  // If congestion, reach destination only with good weather & fuel
- W → (D → ¬C)        // If bad weather, reach destination only without congestion

Theorem: (C ∧ (W ∨ ¬F)) → ¬D
```

### Implementation
- **Formal Proof**: [`201901718.lean`](201901718.lean) - Lean4 theorem prover implementation
- **Visual Proof**: Handwritten nested fraction-tree derivation (see images)

## 🥪 Project 2: Sandwich Ontology

Knowledge representation framework modeling sandwich types and their relationships.

### Features
- **37 Classes**: Hierarchical organization from basic types to cultural variants
- **5 Object Properties**: Structure and ingredient relationships
- **Modal Logic**: Spatial constraints and cultural accommodations
- **Formal Axioms**: e.g., `Double_Decker ≡ Closed_Sandwich ⊓ (= 3 containsBread.Bread)`

### Key Constraints (Prolog)
```prolog
% Bread and filling separation
answer1(and(implies(bread, not(filling)), implies(filling, not(bread)))).

% Filling must have bread above and below (except open sandwiches)
answer2(implies(and(filling, not(open)), and(dia(oneabove, bread), dia(onebelow, bread)))).
```

## 📁 Repository Structure

```
├── 201901718.lean      # Lean4 formal proofs (4 scenarios + exercises)
├── 201901718.pl        # Prolog modal logic implementation
├── 201901718.owx       # OWL/XML ontology definition
├── 201901718.docx      # Detailed ontology report
├── images/             # Handwritten proof derivations
└── README.md          # This file
```

## 🛠️ Technologies

- **Lean4** - Interactive theorem prover
- **Prolog** - Logic programming (SWI-Prolog/SWISH)
- **OWL** - Web Ontology Language
- **Modal Logic** - Reasoning about possibility/necessity

## 🚀 Getting Started

### Prerequisites
```bash
# Install Lean4
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Install SWI-Prolog
apt-get install swi-prolog  # Linux
brew install swi-prolog     # macOS
```

### Running Examples

```bash
# Run Lean4 proofs
lean --run 201901718.lean

# Test Prolog constraints
swipl -s 201901718.pl
?- showWhere(bread).
?- holds(answer1, [0,0]).
```

### View Ontology
Open `201901718.owx` in [Protégé](https://protege.stanford.edu/) or any OWL editor.

## 💡 Key Insights

1. **Formal Verification**: Provides mathematical guarantees for safety-critical AI decisions
2. **Knowledge Representation**: Enables automated reasoning and cross-cultural adaptability
3. **Modal Logic**: Captures spatial and conditional relationships effectively

## 📚 Documentation

- [Ontology Report](201901718.docx) - Detailed analysis of the sandwich ontology
- [Lean4 Proofs](201901718.lean) - Complete formal verification code
- [Prolog Implementation](201901718.pl) - Modal logic constraints and examples

## 🎯 Applications

- **Autonomous Systems**: Safety verification for critical decisions
- **Knowledge Management**: Automated reasoning for classification systems
- **Cross-cultural AI**: Accommodating diverse worldviews in formal systems

## 👤 Author

**S. Safdar**
- Interest: Formal methods in AI safety
- Focus: Bridging logic programming and machine learning

## 📄 License

This project is for educational purposes, demonstrating knowledge representation and reasoning techniques.

---

*"Most coding examples in ML involve algorithms written in Python and R. I was intrigued to see how predicate logic and proofs can also be used in designing secure AI systems."* - W. Saqib

## Module acknowledgement

Completed for **Knowledge Representation and Reasoning** as part of my University of Leeds MSc Artificial Intelligence studies. Thank you to [Dr Shabbar Naqvi](https://www.linkedin.com/in/dr-shabbar-naqvi-a740b19/) for the teaching and guidance.

[Full portfolio](https://saqibsafdar.com/projects/) · [GitHub profile](https://github.com/saqibsafdar11)
