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


mod TestProduce {
    
    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Rule.{Rule}
    use MiniDatalog.Syntax.Term.{Var, Sym}

    @test
    def produce01(): Unit \ IO = 
        let rule = Rule( Atom("p", Vector#{Var("X"), Var("Z")}) 
                        , Atom("p", Vector#{Var("X"), Var("Y")}) :: Atom("p", Vector#{Var("Y"), Var("Z")}) :: Nil);
        let facts = Atom("p", Vector#{Sym("a"), Sym("b")}) :: Atom("p", Vector#{Sym("b"), Sym("c")}) :: Nil;
        println("produce01:");
        MiniDatalog.Produce.produce(rule, facts) |> println


    /// This should produce None 
    @test
    def produce02(): Unit \ IO = 
        let rule = Rule( Atom("p", Vector#{Var("X"), Var("Z")}) 
                        , Atom("p", Vector#{Var("X"), Var("Y")}) :: Atom("p", Vector#{Var("Y"), Var("Z")}) :: Nil);
        let facts = Atom("p", Vector#{Sym("b"), Sym("c")}) :: Atom("p", Vector#{Sym("a"), Sym("b")}) :: Nil;
        println("produce02:");
        MiniDatalog.Produce.produce(rule, facts) |> println


}