import Foundation

protocol Delegate {
    func didFinishProcessingRequest(response: Result<WeatherModel, WeatherError>)
}

protocol NetworkManager {
    func getWeather(completiton: @escaping(Result<WeatherModel, WeatherError>)->Void)
}

class ViewModel {
    var delegate: Delegate?

    var networkManager: NetworkManager

    init(withNetworkmanager networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func startProcess() {
        networkManager.getWeather(completiton: { [weak self] result in
            self?.delegate?.didFinishProcessingRequest(response: result)
        })
    }
}
