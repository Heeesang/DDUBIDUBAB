import UIKit
import RxSwift
import RxCocoa

final class MenuViewController: BaseVC<MenuViewModel>, MenuInfoProtocol {
    var model: SchoolInfo?
    
    var menuData = PublishSubject<[MenuInfo]>()
    var dishName = PublishSubject<[String]>()
    
    private let disposeBag = DisposeBag()
    
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
    
    private let menuTableView = UITableView().then {
        $0.backgroundColor = .gray
        $0.register(MenuCell.self, forCellReuseIdentifier: MenuCell.cellId)
    }
    
    private lazy var menuTypeSegmentedControl = UISegmentedControl(items: menuType).then {
        $0.selectedSegmentIndex = 1
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
    
    private func bindTableView() {
        dishName.bind(to: menuTableView.rx.items(cellIdentifier: MenuCell.cellId, cellType: MenuCell.self)) { (row, data, cell) in
            cell.changeCellNameData(with: data)
            print(data)
            
        }.disposed(by: disposeBag)
    }
    
    private func fetchMenuData() {
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: Date())
        
        guard let atptCode = model?.atptCode else { return }
        guard let schoolCode = model?.schoolCode else { return }
        let mealDate = date
        
        viewModel.fetchMenuInfo(mealDate: "20221207", atptCode: atptCode, schoolCode: schoolCode)
    }
    
    override func addView() {
        view.addSubViews(titleLabel, menuContainerView, menuTypeSegmentedControl)
        menuContainerView.addSubview(menuTableView)
    }
    
    override func configureVC() {
        let date = dateFormatter.string(from: Date())
        viewModel.delegate = self
        
        menuTableView.rowHeight = 500
        
        bindTableView()
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
        
        menuTableView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
    }
}
