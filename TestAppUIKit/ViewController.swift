import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewModel = ViewModel(withNetworkmanager: WeatherNetworkManager())
        
        viewModel.delegate = self
        viewModel.startProcess()
    }

    private func setData(_ model: WeatherModel) {
        // Do some actions
    }

    private func handleError(_ error: WeatherError) {
        // Do some actions
    }
}

extension ViewController: Delegate {
    func didFinishProcessingRequest(response: Result<WeatherModel, WeatherError>) {
        switch response {
        case let .success(model):
            setData(model)
        case let .failure(error):
            handleError(error)
        }
    }
}

