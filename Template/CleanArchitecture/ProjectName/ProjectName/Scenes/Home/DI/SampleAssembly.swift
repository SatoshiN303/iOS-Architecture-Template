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
        
        container.register(SampleUseCase.self) { (r, presenter: SamplePresenter) -> SampleUseCase in
            let usecase = SampleUseCase()
            usecase.presenter = presenter
            usecase.gateway = r.resolve(SampleGateway.self, argument: usecase)
            return usecase
        }
        
        container.register(SampleGateway.self) { (r, usecase: SampleUseCase) -> SampleGateway in
            let gateway = SampleGateway()
            return gateway
        }
        
        container.register(SamplePresenter.self) { (r, vc: SampleViewController) in
            let presenter = SamplePresenter()
            presenter.view = vc
            presenter.usecase = r.resolve(SampleUseCase.self, argument: presenter)
            return presenter
        }
        
        container.storyboardInitCompleted(SampleViewController.self) { (r, vc) in
            vc.presenter = r.resolve(SamplePresenter.self, argument: vc)
        }
    }
    
}
