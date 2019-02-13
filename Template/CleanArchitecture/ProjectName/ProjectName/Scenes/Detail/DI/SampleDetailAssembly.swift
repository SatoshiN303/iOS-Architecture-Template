//
//  SampleDetailAssembly.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class SampleDetailAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(SampleDetailPresenter.self) { (r, vc: SampleDetailViewController) in
            let presenter = SampleDetailPresenter(view: vc)
            return presenter
        }
        
        container.storyboardInitCompleted(SampleDetailViewController.self) { (r, vc) in
            vc.presenter = r.resolve(SampleDetailPresenter.self, argument: vc)
        }
    }
}
