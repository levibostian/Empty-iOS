import Empty
import UIKit

class ViewController: UIViewController {
    private var didSetupConstraints = false

    enum EmptyButtons: String {
        case retry
        case dontRetry
    }

    let emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = AccessibilityIdentifiers.emptyView
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green // Setting background color to demonstrate the `PleaseHoldView` has a default backtround color of transparent so it adapts to the background color you set of parent.
        view.addSubview(emptyView)
        setupViews()

        view.setNeedsUpdateConstraints()
    }

    private func setupViews() {
        emptyView.title = "Error"
        emptyView.message = "An error occurred. Would you like to retry?"
        emptyView.delegate = self

        emptyView.addButton(id: EmptyButtons.retry.rawValue, message: "Retry")
        emptyView.config.newButton = {
            let button = EmptyViewConfig.defaultButton
            button.setTitleColor(.blue, for: .normal)
            return button
        }

        emptyView.addButton(id: EmptyButtons.dontRetry.rawValue, message: "Dont Retry")
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            let superviewMargins = view.layoutMarginsGuide

            emptyView.leadingAnchor.constraint(equalTo: superviewMargins.leadingAnchor).isActive = true
            emptyView.topAnchor.constraint(equalTo: superviewMargins.topAnchor).isActive = true
            emptyView.trailingAnchor.constraint(equalTo: superviewMargins.trailingAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: superviewMargins.bottomAnchor).isActive = true

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }
}

extension ViewController: EmptyViewDelegate {
    func buttonPressed(id: String) {
        guard let buttonPressed = EmptyButtons(rawValue: id) else {
            return
        }

        let alert: UIAlertController
        switch buttonPressed {
        case .retry:
            alert = UIAlertController(title: nil, message: "Retry button pressed", preferredStyle: .alert)
        case .dontRetry:
            alert = UIAlertController(title: nil, message: "Don't retry button pressed", preferredStyle: .alert)
        }

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}
