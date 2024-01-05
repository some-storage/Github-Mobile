import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    private let menuStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .equalSpacing
    }

    private let trophyButton = UIButton(type: .system).then {
        $0.setTitle("TrophyButton", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [
            trophyButton
        ].forEach(menuStack.addArrangedSubview(_:))
        view.addSubview(menuStack)
        menuStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        handleButtonAction()
    }
    
    private func handleButtonAction() {
        trophyButton.addTarget(self, action: #selector(presentTrophyView), for: .touchUpInside)
    }

    @objc func presentTrophyView(sender: UIButton) {
        let tropyView = TrophyViewController()
        tropyView.modalPresentationStyle = .fullScreen
        present(tropyView, animated: true)
    }
}

