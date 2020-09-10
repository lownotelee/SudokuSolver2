import UIKit

class BaseSquare: UIView {
    
    var cellsWide: Int
    let boxWidth: Int
    let thickLine: CGFloat = 5
    let thinLine: CGFloat  = 1
    
    init(_ cellsWide: Int) {
        self.cellsWide = cellsWide
        self.boxWidth = Int(sqrt(Double(cellsWide)))
        super.init(frame: .zero)
        backgroundColor = .systemGray2
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
