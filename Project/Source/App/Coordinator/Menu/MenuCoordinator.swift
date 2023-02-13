import UIKit

final class MenuCoordinator: BaseCoordinator {
    
    override func start() {
        let vm = MenuViewModel(coordinator: self)
        let vc = MenuViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
