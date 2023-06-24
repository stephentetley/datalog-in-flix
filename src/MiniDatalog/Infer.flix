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


    pub def infer(rules: List[Rule], facts: List[Atom]): List[Fact] = 
        def loop(s, k) = {
            let snew = union(s, infer1(rules, s));
            if (snew == s) k(snew) else loop(snew, k)
        };
        loop(facts, identity)


    /// TODO - I'm not sure what the inner FOR EACH in Ceri, et al is doing. 
    /// `loop` looks at successive list tails which does produce the same answer (for the test data)
    pub def infer1(rules: List[Rule], facts: List[Atom]): List[Fact] = 
        let groundFacts = List.filter(groundAtom, facts);
        def loop(vs, r, acc) = match vs { 
            case _ :: rest => match produce(r, vs) {
                case Some(newfact) => loop(rest, r, snoc(acc, newfact))
                case None          => acc
            }
            case Nil       => acc
        };
        let ruleStep = (acc, r) -> loop(groundFacts, r, acc);
        List.foldLeft(ruleStep, Nil, rules)

    def snoc(xs: List[Atom], x: Atom): List[Atom] = 
        if (List.memberOf(x, xs)) xs else List.append(xs, x :: Nil) 

    // def cons(x: Atom, xs: List[Atom]): List[Atom] = 
    //     if (List.memberOf(x, xs)) xs else x :: xs

    def union(xs: List[Atom], ys: List[Atom]): List[Atom] = 
        List.foldLeft((acc, x) -> snoc(acc, x), xs, ys)


}
