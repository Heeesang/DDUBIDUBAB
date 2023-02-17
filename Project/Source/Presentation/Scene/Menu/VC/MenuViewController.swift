import UIKit
import RxSwift
import RxCocoa

final class MenuViewController: BaseVC<MenuViewModel> {
    var model: SchoolInfo?
    
    var dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy년 MM월 dd일"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "밥"
        $0.font = .systemFont(ofSize: 21, weight: .bold)
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
    
    private func fetchMenuData() {
        guard let atptCode = model?.atptCode else { return  }
        guard let schoolCode = model?.schoolCode else { return  }
        
        viewModel.fetchMenuInfo(atptCode: atptCode, schoolCode: schoolCode)
    }
    
    override func addView() {
        view.addSubViews(titleLabel, menuContainerView)
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
    }
}
