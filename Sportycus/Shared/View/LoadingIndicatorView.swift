import Foundation

import UIKit

class LoadingIndicatorView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func show(in parentView: UIView) {
        frame = parentView.bounds
        parentView.addSubview(self)
        activityIndicator.startAnimating()
    }

    func hide() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}

