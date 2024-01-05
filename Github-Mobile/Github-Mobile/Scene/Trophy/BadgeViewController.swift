import UIKit
import SnapKit
import Then

class BadgeViewController: UIViewController {

    private let badgeSrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }

    private let badgeStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
    }

    private let badgeImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.borderWidth = 12
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 50
        $0.contentMode = .scaleAspectFit
    }

    private let badgeNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
    }

    private let badgeExplainLabel = UILabel().then {
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let badgeHistoryView = BadgeHistoryView()

    public func setupBadge(
        badgeImage: UIImage,
        badgeName: String,
        badgeExplain: String,
        collectDate: String,
        pointColor: UIColor,
        historys: [BadgeHistory]
    ) {
        badgeImageView.image = badgeImage
        badgeNameLabel.text = badgeName
        badgeExplainLabel.text = badgeExplain
        badgeHistoryView.setHistory(collectDate: collectDate, historys: historys)
        badgeSrollView.contentInset = .init(top: view.frame.height / 8.5, left: 0, bottom: 0, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        badgeImageView.layer.cornerRadius = (view.frame.width - 120) / 2
    }

    override func viewDidLayoutSubviews() {
        addsubView()
        layout()
    }

    private func addsubView() {
        [
            badgeImageView,
            badgeNameLabel,
            badgeExplainLabel,
            badgeHistoryView
        ].forEach { badgeStackView.addArrangedSubview($0) }
        badgeSrollView.addSubview(badgeStackView)
        view.addSubview(badgeSrollView)
    }

    private func layout() {
        badgeSrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        badgeImageView.snp.makeConstraints {
            $0.width.height.equalTo(view.frame.width - 120)
        }
        badgeStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        badgeStackView.setCustomSpacing(10, after: badgeNameLabel)
        badgeStackView.setCustomSpacing(40, after: badgeExplainLabel)
    }
}

extension BadgeViewController {
    public func setBadge3DAngle(angle: CGFloat) {
        badgeImageView.transform3D = CATransform3DMakeRotation(angle, 0, 1, 0)
    }
}
