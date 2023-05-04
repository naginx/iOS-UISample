import UIKit


final class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var counter = Counter()

    @IBAction private func tappedDecrementButton(_ sender: UIButton) {
        counter.decrement()
        updateView()
    }

    @IBAction private func tappedIncrementButton(_ sender: UIButton) {
        counter.increment()
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(counter.count)"
        decrementButton.isEnabled = !counter.isLowerLimit
        incrementButton.isEnabled = !counter.isUpperLimit
    }
}
