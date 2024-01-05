import UIKit

public struct TropyModel {
    let badgeImage: UIImage
    let badgeName: String
    let badgeExplan: String
    let backgroundColor: UIColor
    let collectDate: String
    let historys: [BadgeHistory]
}

public struct BadgeHistory: Equatable {
    let repositoryName: String
    let detail: String
}

private let dumyDistory: [BadgeHistory] = [
    .init(
        repositoryName: "GRAM-DSM/SharingMyWishlist-iOS#4",
        detail: "2nd pull request"
    ),
    .init(
        repositoryName: "GRAM-DSM/SharingMyWishlist-iOS#4",
        detail: "2nd pull request"
    )
]

public let troypData: [TropyModel] = [
    .init(
        badgeImage: .appleBadge,
        badgeName: "Apple",
        badgeExplan: "You want it? You merge it.",
        backgroundColor: .github1,
        collectDate: "10월 16, 2023 잠금 해제됨",
        historys: dumyDistory
    ),
    .init(
        badgeImage: .swiftBadge,
        badgeName: "Swift",
        badgeExplan: "Gitty up!",
        backgroundColor: .github2,
        collectDate: "12월 16, 2021 잠금 해제됨",
        historys: dumyDistory
    ),
    .init(
        badgeImage: .xcodeBadge,
        badgeName: "Xcode",
        badgeExplan: "Gitty up!",
        backgroundColor: .github3,
        collectDate: "6월 16, 2023 잠금 해제됨",
        historys: dumyDistory
    ),
    .init(
        badgeImage: .moyaBadge,
        badgeName: "Moya",
        badgeExplan: "Gitty up!",
        backgroundColor: .github4,
        collectDate: "8월 16, 2022 잠금 해제됨",
        historys: dumyDistory
    ),
    .init(
        badgeImage: .rxswiftBadge,
        badgeName: "RxSwift",
        badgeExplan: "Gitty up!",
        backgroundColor: .github5,
        collectDate: "8월 16, 2022 잠금 해제됨",
        historys: dumyDistory
    )
]
