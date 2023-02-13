import UIKit
import RxSwift
import RxCocoa

class MenuViewController: BaseVC<MenuViewModel> {
    var model: SchoolInfo?
    
    private let titleLabel = UILabel().then {
        $0.text = "밥"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private let menuContainerView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    init(viewModel: MenuViewModel, model: SchoolInfo) {
        super.init(viewModel: viewModel)
        self.model = model

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addView() {
        view.addSubViews(titleLabel, menuContainerView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        menuContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.bottom.equalToSuperview().inset(230)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }
}
