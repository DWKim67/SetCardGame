//
//  CardContent.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-09.
//

import Foundation

struct CardContent: Equatable {
    let color: String
    let number: Int
    let shape: String
    let shading: String
    
    init(color: String, number: Int, shape: String, shading: String) {
        self.color = color
        self.number = number
        self.shape = shape
        self.shading = shading
    }
    
    func isSetMatch(content1: CardContent, content2: CardContent) -> Bool {
        if !isPropertyMatch(selfProp: self.color, content1Prop: content1.color, content2Prop: content2.color) {
            return false
        }
        
        if !isPropertyMatch(selfProp: self.number, content1Prop: content1.number, content2Prop: content2.number) {
            return false
        }
        
        if !isPropertyMatch(selfProp: self.shape, content1Prop: content1.shape, content2Prop: content2.shape) {
            return false
        }
        
        if !isPropertyMatch(selfProp: self.shading, content1Prop: content1.shading, content2Prop: content2.shading) {
            return false
        }
        
        
        return true
    }
    
    private func isPropertyMatch<Prop: Equatable>(selfProp: Prop, content1Prop: Prop, content2Prop: Prop) -> Bool {
        if (selfProp == content1Prop && selfProp != content2Prop) ||
            (selfProp != content1Prop && selfProp == content2Prop) ||
            (content1Prop != content2Prop && selfProp == content2Prop)  ||
            (content1Prop == content2Prop && selfProp != content2Prop) ||
            (content1Prop != content2Prop && selfProp == content1Prop) ||
            (content1Prop == content2Prop && selfProp != content1Prop) {
            print("Printed false, props being \(selfProp), \(content2Prop), \(content1Prop)")
            return false
        }
        print("Printed true, self.prop being \(selfProp)")
        
        return true
    }
}
