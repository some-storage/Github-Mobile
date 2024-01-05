import UIKit
import SnapKit
import Then

class BadgeHistoryView: UIStackView {
    
    private let collectView = UIView()
    private let trophyImageView = UIImageView(image: .trophy)

    private let collectLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 0
    }

    init() {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 0
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setHistory(collectDate: String, historys: [BadgeHistory]) {
        collectLabel.text = collectDate

        historys.enumerated().forEach { index, data in
            let detailView = BadgeHistoryDetailView(
                historyContent: data.repositoryName,
                isLast: index == historys.count - 1
            )
            addArrangedSubview(detailView)
        }
    }

    private func setup() {
        [
            trophyImageView,
            collectLabel
        ].forEach(collectView.addSubview(_:))
        addArrangedSubview(collectView)
        trophyImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        collectLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(trophyImageView.snp.trailing).offset(25)
        }
        collectView.snp.makeConstraints {
            $0.bottom.greaterThanOrEqualTo(trophyImageView.snp.bottom).offset(8)
            $0.bottom.equalTo(collectLabel)
        }
    }
}
