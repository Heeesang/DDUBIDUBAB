import UIKit

final class MenuCoordinator: BaseCoordinator {
    
    func startMenuVC(model: SchoolInfo) {
        let vm = MenuViewModel(coordinator: self)
        let vc = MenuViewController(viewModel: vm, model: model) 
        
        navigationController.pushViewController(vc, animated: true)
    }
}
