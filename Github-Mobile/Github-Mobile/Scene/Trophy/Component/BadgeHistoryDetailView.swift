import UIKit
import SnapKit
import Then

class BadgeHistoryDetailView: UIStackView {

    private let topLineView = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.3)
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.3)
    }
    private let historyContentLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let historyContentView = UIView()
    private let imageContentView = UIView()

    private let dotView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
    }

    init(historyContent: String, isLast: Bool = false) {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 25
        historyContentLabel.text = historyContent
        underLineView.isHidden = isLast
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        [
            dotView,
            topLineView,
            underLineView
        ].forEach(imageContentView.addSubview(_:))
        historyContentView.addSubview(historyContentLabel)
        [
            imageContentView,
            historyContentView
        ].forEach(addArrangedSubview(_:))

        historyContentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        topLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.bottom.equalTo(dotView.snp.top).offset(-4)
            $0.centerX.equalTo(dotView)
            $0.top.equalToSuperview()
        }
        underLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.equalTo(dotView.snp.bottom).offset(4)
            $0.centerX.equalTo(dotView)
            $0.bottom.equalToSuperview()
        }
        historyContentView.snp.makeConstraints {
            $0.bottom.equalTo(historyContentLabel).offset(20)
        }
        dotView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(historyContentLabel)
            $0.width.height.equalTo(14)
            $0.leading.equalToSuperview().inset(10)
        }
    }
}
