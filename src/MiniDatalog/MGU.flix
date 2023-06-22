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

mod MiniDatalog.MGU { 

    use MiniDatalog.Syntax.Atom
    use MiniDatalog.Syntax.Atom.{Atom}    
    use MiniDatalog.Syntax.Term.{Var}
    use MiniDatalog.Syntax.{arity}
    use MiniDatalog.Substitution.Substitution
    use MiniDatalog.Substitution.{lookup, composition1}

    pub def mgu(l: Atom, m: Atom): Option[Substitution] = 
        let Atom(p1, v1) = l;
        let Atom(p2, v2) = m;
        let len = arity(l);
        def loop(i, substs) = {
            if (i >= len) 
                Some(substs)
            else {
                let t = lookup(Vector.get(i, v1), substs);
                let t1 = lookup(Vector.get(i, v2), substs);
                if (t == t1) 
                    loop(i + 1, substs)
                else match t1 {
                    case Var(s) => loop(i+1, composition1(substs, s, t))
                    case _      => match t {
                        case Var(s) => loop(i+1, composition1(substs, s, t1))
                        case _      => None
                    }
                }
            }
        };
        if (p1 != p2 or len != arity(m)) 
            None 
        else 
            loop(0, MiniDatalog.Substitution.empty())

}
