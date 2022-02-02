//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Marcio Alico on 2/2/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getCryptoFromApi()
}

class HomeInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getCryptoFromApi() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCryptos(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.ParsingFailed))
            }
        }
        
        task.resume()
    }
}
