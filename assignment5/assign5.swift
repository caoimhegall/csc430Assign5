//
//  assign5.swift
//  assignment5
//
//  Created by caoimhe on 6/3/20.
//  Copyright © 2020 caoimhe. All rights reserved.
//

import Foundation

protocol ExprC {
}

class NumC: ExprC {
  var v: Double
  init(v: Double) {
    self.v = v
  }
}
class StrC: ExprC {
  var str: String
  init(str: String) {
    self.str = str
  }
}

class Symbol {
    var sym: String
    init(sym: String) {
        self.sym = sym
    }
}

class IdC : ExprC {
    var sym: Symbol
    init(sym: Symbol){
        self.sym = sym
    }
}

class AppC : ExprC {
    var fun : ExprC
    var args : [ExprC]
    init(fun : ExprC, args : [ExprC]){
        self.fun = fun
        self.args = args
    }
}

class IfC: ExprC {
  var test: ExprC
  var then: ExprC
  var els: ExprC
  init(te: ExprC, th: ExprC, e: ExprC){
    self.test = te
    self.then = th
    self.els = e
  }
}

protocol Value {
}

class NumV: Value {
    var n: Double
    init(n: Double){
        self.n = n
    }
}
class BoolV: Value {
    var b: Bool
    init(b: Bool){
        self.b = b
    }
}
class PrimV: Value {
  var s: Symbol
  init(s: Symbol){
    self.s = s
  }
}

class StrV: Value {
  var s: String
  init(s: String){
    self.s = s
  }
}

class ClosV : Value{
    var args : [Symbol]
    var body : ExprC
    var env : Env

    init(args : [Symbol], body : ExprC, env : Env){
        self.args = args
        self.body = body
        self.env = env
    }
    
}

