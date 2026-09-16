//
//  Calculator.swift
//  MovieProject
//
//  Created by Mouli Agastya on 9/16/26.
//

struct Calculator {
    func sum(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else { return 0 }
        return num1 + num2
    }
    
    func sub(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else { return 0 }
        return num1 - num2
    }
    
    func mul(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else { return 0 }
        return num1 * num2
    }
    
    func div(num1: Int?, num2: Int?) -> Int {
        guard let num1, let num2 else { return 0 }
        return num1 / num2
    }
}
