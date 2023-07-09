//
//  ViewController.swift
//  task3
//
//  Created by Nikita Gvozdikov on 08.07.2023.
//

import UIKit

class ViewController: UIViewController {

  private let padding: CGFloat = 15

  private lazy var squareView: UIView = {
    let view = UIView(frame: CGRect(x: padding, y: 100, width: 80, height: 80))
    view.backgroundColor = .systemBlue
    view.layer.cornerRadius = 10
    return view
  }()

  private lazy var sliderView: UISlider = {
    let slider = UISlider()
    slider.minimumValue = 0
    slider.maximumValue = 1
    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchUpInside)
    slider.frame = CGRect(x: padding,
                          y: squareView.frame.maxY + 50,
                          width: view.frame.width - padding * 2,
                          height: 30)
    return slider
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(squareView)
    view.addSubview(sliderView)
  }

  @objc private func sliderValueChanged(_ sender: UISlider) {
    let maxTransform = CGFloat(sender.maximumValue)
    let currentTransform = CGFloat(sender.value) * maxTransform
    let rotation = CGAffineTransform(rotationAngle: currentTransform * (.pi / 2))
    let transform = rotation.scaledBy(x: currentTransform * 0.5 + 1.0, y: currentTransform * 0.5 + 1.0)
    squareView.transform = transform

    let maxX = view.frame.width - padding - squareView.frame.width / 2
    let minX = squareView.frame.width / 2 + padding
    squareView.center.x = minX + (maxX - minX) * CGFloat(sender.value)
  }

  @objc private func sliderTouchUp(_ sender: UISlider) {
    sender.setValue(sender.maximumValue, animated: true)
    UIView.animate(withDuration: 0.5) {
      self.sliderValueChanged(sender)
    }
  }
}
