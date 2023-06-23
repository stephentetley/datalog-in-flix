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

mod MiniDatalog.Syntax { 

    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Term.{Sym, Var}

    pub type alias Program = List[Rule] 

    pub enum Rule with Eq, Order, ToString {
        case Rule(Atom, List[Atom])
    }

    pub type alias Fact = Atom

    pub enum Atom with Eq, Order, ToString {
        case Atom(String, Vector[Term])
    }

    pub enum Term with Eq, Order, ToString {
        case Sym(String)
        case Var(String)
    }


    pub def arity(a: Atom): Int32 = 
        let Atom(_, v) = a;
        Vector.length(v)

    pub def groundTerm(t: Term): Bool = match t {
        case Sym(_) => true
        case Var(_) => false
    }

    pub def groundAtom(a: Atom): Bool = 
        let Atom(_, v) = a;
        Vector.forAll(groundTerm, v)

}