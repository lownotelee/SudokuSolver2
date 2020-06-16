import UIKit

class DrawExamples: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //context is the object used for drawing
        let context = UIGraphicsGetCurrentContext()
        
        var lineWidth: Int
        
        for horizontalScaler in 0...9 {
            if horizontalScaler % 3 == 0 {
                lineWidth = 8
            } else {
                lineWidth = 1
            }

            context!.setLineWidth(CGFloat(lineWidth))

            context!.setStrokeColor(UIColor.black.cgColor)
            // make an invisible path first, then we fill it in
            context!.move(to: CGPoint(x:0, y:bounds.width*(CGFloat(horizontalScaler)/9)))
            context!.addLine(to: CGPoint(x:bounds.width, y:bounds.width*(CGFloat(horizontalScaler)/9)))

            // actually draw the path
            context!.strokePath()
        }
        for verticalScaler in 0...9 {
            if verticalScaler % 3 == 0 {
                lineWidth = 8
            } else {
                lineWidth = 1
            }

            context!.setLineWidth(CGFloat(lineWidth))

            context!.setStrokeColor(UIColor.black.cgColor)
            // make an invisible path first, then we fill it in
            context!.move(to: CGPoint(x: CGFloat(bounds.width*(CGFloat(verticalScaler)/9)), y:0))
            context!.addLine(to: CGPoint(x:bounds.width*(CGFloat(verticalScaler)/9), y:bounds.width))

            // actually draw the path
            context!.strokePath()
        }
    }

}
