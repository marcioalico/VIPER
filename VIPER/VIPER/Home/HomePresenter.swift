//
//  HomePresenter.swift
//  VIPER
//
//  Created by Marcio Alico on 2/2/22.
//

import Foundation

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var view: AnyView? { get set }
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    
    func interactorDidDownloadCryptos(result: Result<[Crypto], Error>)
}

class HomePresenter: AnyPresenter {
    var view: AnyView?
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getCryptoFromApi()
        }
    }
    
    func interactorDidDownloadCryptos(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: "Oops! An error has occured. Please, try again later..")
        }
    }
}
