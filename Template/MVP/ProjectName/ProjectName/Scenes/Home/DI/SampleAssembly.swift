//
//  SampleAssembly.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2019/02/09.
//  Copyright © 2019年 'XLOrganizationName'. All rights reserved.
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
