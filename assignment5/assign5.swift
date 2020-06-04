//
//  assign5.swift
//  assignment5
//
//  Created by caoimhe on 6/3/20.
//  Copyright © 2020 caoimhe. All rights reserved.
//

import Foundation

enum UnboundIdError: Error{
  case noIdFoundInEnv
}

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
extension Symbol: Hashable {
    static func == (lhs: Symbol, rhs: Symbol) -> Bool {
        return lhs.sym == rhs.sym && lhs.sym == rhs.sym
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sym)
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

class LamC: ExprC {
  var args: [Symbol]
  var body: ExprC
    init(a: [Symbol], b: ExprC){
    self.args = a
    self.body = b
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

protocol Val {
}

class NumV: Val {
    var v: Double
    init(v: Double){
        self.v = v
    }
}
extension NumV: Equatable {
    static func == (lhs: NumV, rhs: NumV) -> Bool {
    lhs.v == rhs.v
  }

}
class BoolV: Val {
    var b: Bool
    init(b: Bool){
        self.b = b
    }
}
class PrimV: Val {
  var s: Symbol
  init(s: Symbol){
    self.s = s
  }
}

class StrV: Val {
  var s: String
  init(s: String){
    self.s = s
  }
}

class Env {
    var e: [Symbol : Val] = [:]
    init(e: [Symbol : Val] = [:]){
        self.e = e
    }
}

class ClosV : Val{
    var args : [Symbol]
    var body : ExprC
    var env : Env

    init(args : [Symbol], body : ExprC, env : Env){
        self.args = args
        self.body = body
        self.env = env
    }
    
}

func interp(e : ExprC, env: Env) throws -> Val {
  switch e {
  case let n as NumC:
    return NumV(v : n.v)
  case let st as StrC:
    return StrV(s: st.str)
  case let l as LamC:
    return ClosV(args: l.args, body: l.body, env: env)
  case let id as IdC:
    if let res = env.e[id.sym]{
        return res
    }
    else {
        throw UnboundIdError.noIdFoundInEnv
    }
    case let i as IfC:
        let tstval = try interp(e: i.test, env: env)
        
        switch tstval{
        case let b as BoolV:
            if b.b { return try interp(e: i.then, env: env) }
            else{ return try interp(e: i.els, env: env) }
        default:
          // error message here
          return NumV(v: 3)
      }
    case let a as AppC:
      let fn = try interp(e: a.fun, env: env)
      let argvals = try a.args.map { try interp(e: $0, env: env) }
      switch fn {
        case let clos as ClosV:
          for i in 0...a.args.count {
            clos.env.e[clos.args[i]] = argvals[i]
          }
          return try interp(e: clos.body, env: clos.env)
        case let prim as PrimV:
          return NumV(v: 3)
        default:
          return NumV(v: 3)
      }


    default:
        return NumV(v: 3)
  }
}

