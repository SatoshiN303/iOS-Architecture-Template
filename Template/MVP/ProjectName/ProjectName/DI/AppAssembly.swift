//
//  AppAssembly .swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class AppAssembly {
    
    class var assembler: Assembler? {
        return Assembler([
            SampleAssembly()
            ])
    }
}

extension SwinjectStoryboard {
    @objc class  func setup() {
        guard let assembler = AppAssembly.assembler,
              let container =  assembler.resolver as? Container else {
                fatalError()
        }
        defaultContainer = container
    }
}
