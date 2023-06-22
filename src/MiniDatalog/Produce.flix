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

mod MiniDatalog.Produce { 

    use MiniDatalog.Syntax.Atom
    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Fact
    use MiniDatalog.Syntax.Rule
    use MiniDatalog.Syntax.Rule.{Rule}
    use MiniDatalog.Syntax.Term.{Var}
    use MiniDatalog.Substitution.{lookupAtom}
    use MiniDatalog.MGU.{mgu}

    pub def produce(rule: Rule, facts: List[Fact]): Option[Fact] = 
        let Rule(head, body) = rule;
        def loop(ls, fs, acc) = match (ls, fs) {
            case (l :: rest1, f :: rest2) => match mgu(l, f) {
                case None         => None
                case Some(substs) => loop(List.map(a1 -> lookupAtom(a1, substs), rest1), rest2, lookupAtom(acc, substs))
            }
            case (_, _)           => Some(acc)
        };
        loop(body, facts, head)

}
