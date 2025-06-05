import Foundation
import UIKit

let tag = 100


extension UIViewController {
    
    func showNetworkUnavailableAlert(
        title: String = "No Internet",
        message: String = "Please check your connection."
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true)
    }
    
    func showIndicator(style: UIActivityIndicatorView.Style = .large, color: UIColor = .gray) {
        if view.viewWithTag(tag) != nil { return }
        
        let indicator = UIActivityIndicatorView(style: style)
        indicator.tag = tag
        indicator.color = color
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func hideIndicator() {
        if let indicator = view.viewWithTag(tag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}

