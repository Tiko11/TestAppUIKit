import Foundation

enum WeatherError:Error{
    case noDataAvailable
    case cantProcessData
}

class WeatherNetworkManager: NetworkManager{

    var resourceURL: URL
    let apiKEY = "b4fabebb89251b0e1dfa59900ad7423f"

    init() {
        var resourceString = "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=\(apiKEY)"
        resourceString = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? resourceString

        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }

    func getWeather(completiton: @escaping(Result<WeatherModel, WeatherError>)->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else{
                completiton(.failure(.noDataAvailable))
                return
            }

            do{
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherModel.self, from: jsonData)
                completiton(.success(weatherResponse))
            } catch{
                completiton(.failure(.cantProcessData))
            }

        }
        dataTask.resume()
    }
}

