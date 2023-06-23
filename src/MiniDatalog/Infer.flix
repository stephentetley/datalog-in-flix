/*
 * Copyright 2023 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

mod MiniDatalog.Infer { 

    use MiniDatalog.Syntax.Atom
    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Fact
    use MiniDatalog.Syntax.Rule
    use MiniDatalog.Syntax.Rule.{Rule}
    use MiniDatalog.Syntax.{groundAtom}
    use MiniDatalog.Produce.{produce}
    // use MiniDatalog.MGU.{mgu}

    /// TODO - the inner FOR EACH appears to be indicating groupBy "phi" i.e. atom name...
    /// We send a list if lists...
    pub def infer1(rules: List[Rule], facts: List[List[Atom]]): Set[Fact] = 
        let groundFacts = List.filterMap(xs -> match List.filter(groundAtom, xs) { 
            case Nil => None
            case xs1 => Some(xs1) 
        }, facts);
        let ruleStep = (acc, r) -> List.foldLeft((acc1, nfacts) -> match produce(r, nfacts) {
            case Some(newfact) => Set.insert(newfact, acc1)
            case None => acc1
        }, acc, groundFacts);
        List.foldLeft(ruleStep, Set.empty(), rules)

}
