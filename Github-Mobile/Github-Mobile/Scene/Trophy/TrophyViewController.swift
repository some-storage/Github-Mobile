import UIKit
import SnapKit
import Then

class TrophyViewController: UIViewController {

    var controllers: [UIViewController] = []
    var pendingIndex: Int = 0
    var nowIndex: Int = 0

    private let corverView = UIView()

    private let backButton = UIButton().then {
        $0.setImage(.xMark, for: .normal)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .white.withAlphaComponent(0.3)
    }

    private let badgePageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )

    private let pageController = UIPageControl()

    private let shearButton = UIButton(type: .system).then {
        $0.setTitle("공유", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .white.withAlphaComponent(0.5)
        $0.titleLabel?.font = .systemFont(ofSize: 25, weight: .heavy)
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        [view, corverView].forEach { $0?.backgroundColor = troypData[0].backgroundColor}
        
        controllers = troypData.map {
            let view = BadgeViewController()
            view.setupBadge(
                badgeImage: $0.badgeImage,
                badgeName: $0.badgeName,
                badgeExplain: $0.badgeExplan,
                collectDate: $0.collectDate,
                pointColor: $0.backgroundColor,
                historys: $0.historys
            )
            return view
        }
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        settingPageViewController()
    }

    override func viewDidLayoutSubviews() {
        addsubView()
        layout()
    }

    private func settingPageViewController() {
        addChild(badgePageViewController)
        let scrollView = badgePageViewController.view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        badgePageViewController.delegate = self
        badgePageViewController.dataSource = self

        badgePageViewController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        pageController.addTarget(self, action: #selector(handlePageController), for: .valueChanged)
        pageController.numberOfPages = controllers.count
    }

    private func addsubView() {
        [
            corverView,
            badgePageViewController.view,
            backButton,
            pageController,
            shearButton
        ].forEach { view.addSubview($0) }
    }

    private func layout() {
        corverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        badgePageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(pageController.snp.top).offset(-20)
        }
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.trailing.equalToSuperview().inset(20)
        }
        pageController.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(shearButton.snp.top).offset(-20)
        }
        shearButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    @objc func handlePageController(sender: UIPageControl) {
        
        view.backgroundColor = troypData[sender.currentPage].backgroundColor
        badgePageViewController.setViewControllers(
            [controllers[sender.currentPage]],
            direction: sender.currentPage > nowIndex ? .forward : .reverse,
            animated: true,
            completion: { [weak self] _ in
                guard let self else { return }
                nowIndex = sender.currentPage
                corverView.backgroundColor = troypData[nowIndex].backgroundColor
            }
        )
    }

    @objc func backButtonClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension TrophyViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let angle = .pi * ((scrollView.contentOffset.x - view.frame.width) / view.frame.width) * 2

        controllers.forEach {
            guard let view = $0 as? BadgeViewController else { return }
            view.setBadge3DAngle(angle: angle)
        }

        corverView.layer.opacity = Float(1 - abs(((scrollView.contentOffset.x - view.frame.width) / view.frame.width)))
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var selectController: UIViewController? = nil
        if let index = controllers.firstIndex(of: viewController) {
            if index <= 0 {
                selectController = controllers[controllers.count - 1]
            } else {
                selectController = controllers[index - 1]
            }
        }
        return selectController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var selectController: UIViewController? = nil
        if let index = controllers.firstIndex(of: viewController) {
            if index >= controllers.count - 1 {
                selectController = controllers[0]
            } else {
                selectController = controllers[index + 1]
            }
        }
        return selectController
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = controllers.firstIndex(of: pendingViewControllers.first!) ?? 0
        view.backgroundColor = troypData[pendingIndex].backgroundColor
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            pageController.currentPage = pendingIndex
            corverView.backgroundColor = troypData[pendingIndex].backgroundColor
        }
    }
}
