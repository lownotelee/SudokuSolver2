import UIKit

class BaseSquare: UIView {

    var cellsWide: Int
    let boxWidth: Int
    let thickLine: CGFloat = 5
    let thinLine: CGFloat  = 1

    var viewList: [CellView] = []

    let xAxisStack   = UIStackView()

    init(_ cellsWide: Int) {
        self.cellsWide = cellsWide
        self.boxWidth = Int(sqrt(Double(cellsWide)))
        super.init(frame: .zero)
        backgroundColor = .systemGray2
        makeListOfCells()
        setUpXAxisStackView()
        fillStacks()
        buildVStack()
        makeOneCellRed()
    }

    func makeListOfCells() {
        for _ in 0..<(cellsWide * cellsWide) {
            viewList.append(CellView(cellNumber: "f", textColor: .black))
        }
    }

    func setUpXAxisStackView() {
        xAxisStack.axis = .horizontal
        xAxisStack.alignment = .fill
        xAxisStack.distribution = .fillEqually
        xAxisStack.translatesAutoresizingMaskIntoConstraints = false
    }

    func setUpYAxisStackView(stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func fillStacks() {
        for i in 0..<cellsWide {
            let yAxisStack = UIStackView()
            setUpYAxisStackView(stackView: yAxisStack)

            for j in 0..<cellsWide {
                yAxisStack.addArrangedSubview(viewList[(i*cellsWide + j)])

            }
            xAxisStack.addArrangedSubview(yAxisStack)
        }
    }

    func buildVStack() {
        self.addSubview(xAxisStack)

        NSLayoutConstraint.activate([
            xAxisStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            xAxisStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            xAxisStack.topAnchor.constraint(equalTo: self.topAnchor),
            xAxisStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func makeOneCellRed() {
        
    }

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        var lineWidth: CGFloat

        for horizontalScaler in 0...cellsWide {
            if horizontalScaler % boxWidth == 0 {
                lineWidth = thickLine
            } else {
                lineWidth = thinLine
            }
            context!.setLineWidth(lineWidth)

            context!.setStrokeColor(UIColor.black.cgColor)
            // make an invisible path first, then we fill it in
            context!.move(to: CGPoint(x:0, y:bounds.width*(CGFloat(horizontalScaler)/CGFloat(cellsWide))))
            context!.addLine(to: CGPoint(x:bounds.width, y:bounds.width*(CGFloat(horizontalScaler)/CGFloat(cellsWide))))

            // actually draw the path
            context!.strokePath()
        }
        for verticalScaler in 0...cellsWide {
            if verticalScaler % boxWidth == 0 {
                lineWidth = thickLine
            } else {
                lineWidth = thinLine
            }

            context!.setLineWidth(CGFloat(lineWidth))

            context!.setStrokeColor(UIColor.black.cgColor)
            // make an invisible path first, then we fill it in
            context!.move(to: CGPoint(x: CGFloat(bounds.width*(CGFloat(verticalScaler)/CGFloat(cellsWide))), y:0))
            context!.addLine(to: CGPoint(x:bounds.width*(CGFloat(verticalScaler)/CGFloat(cellsWide)), y:bounds.width))

            // actually draw the path
            context!.strokePath()
        }
    }
}
