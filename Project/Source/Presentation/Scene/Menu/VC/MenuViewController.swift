import UIKit
import RxSwift
import RxCocoa

final class MenuViewController: BaseVC<MenuViewModel> {
    var model: SchoolInfo?
    
    private let menuType: [String] = ["조식", "중식", "석식"]
    
    private var dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy년 MM월 dd일"
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 21, weight: .bold)
    }
    
    private let menuContainerView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private lazy var menuTypeSegmentedControl = UISegmentedControl(items: menuType).then {
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: .semibold)], for: .selected)
    }
    
    init(viewModel: MenuViewModel, model: SchoolInfo) {
        super.init(viewModel: viewModel)
        self.model = model

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchMenuData() {
        guard let atptCode = model?.atptCode else { return }
        guard let schoolCode = model?.schoolCode else { return }
        
        viewModel.fetchMenuInfo(atptCode: atptCode, schoolCode: schoolCode)
    }
    
    override func addView() {
        view.addSubViews(titleLabel, menuContainerView, menuTypeSegmentedControl)
    }
    
    override func configureVC() {
        let date = dateFormatter.string(from: Date())
        
        fetchMenuData()
        titleLabel.text = date
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        menuContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().inset(210)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        menuTypeSegmentedControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(60)
        }
    }
}
