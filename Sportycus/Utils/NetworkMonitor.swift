import Reachability

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let reachability: Reachability?
//    var onStatusChange: ((Bool) -> Void)?

    private init() {
        reachability = try? Reachability()
//        setupReachability()
        try? reachability?.startNotifier()
    }

//    private func setupReachability() {
//        reachability?.whenReachable = { [weak self] _ in
//            print("Internet available")
//            self?.onStatusChange?(true)
//        }
//
//        reachability?.whenUnreachable = { [weak self] _ in
//            print("No internet")
//            self?.onStatusChange?(false)
//        }
//    }

    func isConnected() -> Bool {
        return reachability?.connection != .unavailable
    }

//    deinit {
//        reachability?.stopNotifier()
//    }
}


extension NetworkMonitor {
    
    func fetchData(completion: @escaping ([String]?, Error?) -> Void) {
        
        if self.isConnected() {
            let leagues: [String] = ["", "", ""]
            completion(leagues, nil)
        } else {
            completion(nil, NetworkError.noInternet)
        }
    }
}

enum NetworkError: Error {
    case noInternet
}
