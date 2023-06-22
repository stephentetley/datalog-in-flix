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

mod TestSubstitution {
    
    use MiniDatalog.Syntax.Term
    use MiniDatalog.Syntax.Term.{Var, Sym}

    @test
    def composition01(): Unit \ IO = 
        let theta = Map#{"X" => Var("Y"), "Y" => Var("U"), "Z" => Var("V")};
        let sigma = Map#{"Y" => Sym("john"), "U" => Var("T"), "V" => Var("T"), "X" => Sym("reuben")};
        println("composition01:");
        MiniDatalog.Substitution.composition(theta, sigma) |> println

    @test
    def composition02(): Unit \ IO = 
        let theta = Map#{"Y" => Var("X")};
        let sigma = Map#{"X" => Var("Z")};
        println("composition02:");
        MiniDatalog.Substitution.composition(theta, sigma) |> println

    @test
    def composition03(): Unit \ IO = 
        let theta = Map#{"Y" => Var("Z"), "X" => Var("Z")};
        let sigma = Map#{"V" => Sym("a")};
        println("composition03:");
        MiniDatalog.Substitution.composition(theta, sigma) |> println

    @test
    def composition04(): Unit \ IO = 
        let theta = Map#{"Y" => Var("Z"), "X" => Var("Z"), "V" => Sym("a")};
        let sigma = Map#{"W" => Var("U")};
        println("substitution04:");
        MiniDatalog.Substitution.composition(theta, sigma) |> println

    @test
    def composition101(): Unit \ IO = 
        let theta = Map#{};
        println("composition101:");
        MiniDatalog.Substitution.composition1(theta, "Y", Var("X)")) |> println

    @test 
    def lookup01(): Unit \ IO = 
        let theta = Map#{};
        println("lookup01:");
        MiniDatalog.Substitution.lookup(Var("Y"), theta) |> println

}