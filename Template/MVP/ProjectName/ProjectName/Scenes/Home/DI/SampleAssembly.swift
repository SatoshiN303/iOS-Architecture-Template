//
//  SampleAssembly.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class SampleAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(SamplePresenter.self) { (r, vc: SampleViewController) in
            let presenter = SamplePresenter(view: vc, model: SampleModel())
            return presenter
        }
        
        container.storyboardInitCompleted(SampleViewController.self) { (r, vc) in
            vc.presenter = r.resolve(SamplePresenter.self, argument: vc)
        }
    }
}
