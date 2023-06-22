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


mod TestMGU {
    
    use MiniDatalog.Syntax.Atom.{Atom}
    use MiniDatalog.Syntax.Term.{Var, Sym}

    @test
    def mgu01(): Unit \ IO = 
        let l = Atom("p", Vector#{Var("X"), Var("Z"), Sym("a"), Var("U")});
        let m = Atom("p", Vector#{Var("Y"), Var("Y"), Var("V"), Var("W")});
        println("mgu01:");
        MiniDatalog.MGU.mgu(l, m) |> println

    @test
    def mgu02(): Unit \ IO = 
        let l = Atom("p", Vector#{Var("X")});
        let m = Atom("p", Vector#{Var("Y")});
        println("mgu02:");
        MiniDatalog.MGU.mgu(l, m) |> println

    @test
    def mgu03(): Unit \ IO = 
        let l = Atom("p", Vector#{Var("X"), Var("Z")});
        let m = Atom("p", Vector#{Var("Y"), Var("Y")});
        println("mgu03:");
        MiniDatalog.MGU.mgu(l, m) |> println

}