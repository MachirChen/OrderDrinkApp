//
//  SelectionButton.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/13.
//

import UIKit

class SelectionButton: UIButton {
    
    enum ButtonStyle {
        case roundedView
        case circleView
    }
    
    private var buttonStyle: ButtonStyle = {
        return ButtonStyle.circleView
    }()
    
    private let selectionStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 2.0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.kebukeBlue.cgColor
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    public let priceTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let checkmarkLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 2.0
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    public var isChecked: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if buttonStyle == .circleView {
            selectionStateView.layer.cornerRadius = selectionStateView.frame.height / 2
        } else {
            selectionStateView.layer.cornerRadius = 5.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(selectionStateView)
        addSubview(title)
        addSubview(priceTitle)
        
        NSLayoutConstraint.activate([
            selectionStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
            selectionStateView.topAnchor.constraint(equalTo: topAnchor),
            selectionStateView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectionStateView.widthAnchor.constraint(equalTo: selectionStateView.heightAnchor),
            
            title.leadingAnchor.constraint(equalTo: selectionStateView.trailingAnchor, constant: 8.0),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            priceTitle.topAnchor.constraint(equalTo: topAnchor),
            priceTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0),
            priceTitle.widthAnchor.constraint(equalTo: title.widthAnchor, multiplier: 0.20),
            priceTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
//        addGestureRecognizer(tapGesture)
        
    }
        
    private func updateSelectionState() {
        selectionStateView.backgroundColor = isChecked ? .kebukeBlue : .clear
        
        if isChecked {
            if buttonStyle == .circleView {
                let checkmarkPath = UIBezierPath(ovalIn: CGRect(x: selectionStateView.bounds.maxX / 2 / 2, y: selectionStateView.bounds.maxY / 2 / 2, width: selectionStateView.bounds.width / 2, height: selectionStateView.bounds.height / 2))
                checkmarkLayer.path = checkmarkPath.cgPath
                checkmarkLayer.fillColor = UIColor.white.cgColor
                checkmarkLayer.lineWidth = 0
                selectionStateView.layer.addSublayer(checkmarkLayer)
            } else {
                let checkmarkPath = UIBezierPath()
                checkmarkPath.move(to: CGPoint(x: selectionStateView.bounds.minX + 0.25 * selectionStateView.bounds.width, y: selectionStateView.bounds.midY))
                checkmarkPath.addLine(to: CGPoint(x: selectionStateView.bounds.midX, y: selectionStateView.bounds.maxY - 0.25 * selectionStateView.bounds.height))
                checkmarkPath.addLine(to: CGPoint(x: selectionStateView.bounds.maxX - 0.25 * selectionStateView.bounds.width, y: selectionStateView.bounds.minY + 0.25 * selectionStateView.bounds.height))
                
                checkmarkLayer.path = checkmarkPath.cgPath
                selectionStateView.layer.addSublayer(checkmarkLayer)
            }
        } else {
            checkmarkLayer.path = nil
        }
    }
    
    @objc private func buttonTapped() {
        isChecked = !isChecked
    }
    
    public func setTitle(_ title: String?, priceTitle: String?, buttonStyle: SelectionButton.ButtonStyle) {
        self.title.text = title
        self.priceTitle.text = priceTitle
        self.buttonStyle = buttonStyle
    }
}
