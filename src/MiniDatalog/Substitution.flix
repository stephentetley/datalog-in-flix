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

mod MiniDatalog.Substitution { 
    
    use MiniDatalog.Syntax.Atom
    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Term
    use MiniDatalog.Syntax.Term.{Var, Sym}


    pub type alias Substitution = Map[String, Term]

    pub def empty(): Substitution = Map.empty()

    pub def domain(s: Substitution): Set[String] = 
        Map.keysOf(s)

    pub def codomain(s: Substitution): List[Term] = 
        Map.valuesOf(s)

    pub def lookup(t: Term, substs: Substitution): Term = match t {
        case Var(s) => match Map.get(s, substs) {
            case Some(ti) => ti
            case None     => t
        }
        case _            => t
    }

    pub def isBound(s: String, substs: Substitution): Bool = Map.memberOf(s, substs)


    pub def lookupAtom(a: Atom, substs: Substitution): Atom =
        let Atom(p, v) = a;
        Atom(p, Vector.map(t1 -> lookup(t1, substs), v))

    pub def composition(theta: Substitution, sigma: Substitution): Substitution =
        let leftStep = (acc, s, t1) -> match lookup(t1, sigma) {
            case Var(s1) if s == s1 => acc
            case t                  => Map.insert(s, t, acc)
        }; 
        let lefts = Map.foldLeftWithKey(leftStep, Map#{}, theta);
        let rightStep = (acc, s, t1) -> match t1 {
            case Sym(_) if isBound(s, theta) => acc
            case t                           => Map.insert(s, t, acc)
        };
        Map.foldLeftWithKey(rightStep, lefts, sigma)

    pub def composition1(theta: Substitution, s: String, t: Term): Substitution =
        composition(theta, Map#{s => t})

}
