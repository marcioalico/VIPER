//
//  HomeRouter.swift
//  VIPER
//
//  Created by Marcio Alico on 2/2/22.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entryPoint: EntryPoint? { get }
    static func start() -> AnyRouter
}

class HomeRouter: AnyRouter {
    
    var entryPoint: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = HomeRouter()
        
        var view: AnyView = HomeView()
        var presenter: AnyPresenter = HomePresenter()
        var interactor: AnyInteractor = HomeInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
}
