//
// Created on 15.01.23
// 
// 

import SceneKit

extension SCNVector3 {
    init(_ value: Double) {
        self.init(value, value, value)
    }
    
    init(_ value: Float) {
        self.init(value, value, value)
    }
    
    init(_ value: CGFloat) {
        self.init(value, value, value)
    }
    
    init(_ value: Int) {
        self.init(value, value, value)
    }
}

func - (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    let x = lhs.x - rhs.x
    let y = lhs.y - rhs.y
    let z = lhs.z - rhs.z
    
    return .init(x, y, z)
}
