//
//  Item.swift
//  tuong_tac_da_cham_Change_clothes
//
//  Created by Thang on 12/15/16.
//  Copyright © 2016 Thang. All rights reserved.
//

import Foundation
import UIKit


class Item: UIImageView{//start
    
    required init?(coder aDecoder: NSCoder) {// mỗi cái class custom lại thì phải có method khởi tạo init
        super.init(coder: aDecoder)
        self.setup()
    }
    func setup()
    {
        self.isUserInteractionEnabled = true // các tương tác đa chạm mới có thể nhận diện
        self.isMultipleTouchEnabled = true // dùng 2 ngón trỏ
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Item.onPan(_:)))
        panGesture.maximumNumberOfTouches = 1 // ?
        panGesture.minimumNumberOfTouches = 1 // ?
        self.addGestureRecognizer(panGesture) // khi khởi tạo ra ta phải add vào thì nó mới chạy dc
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(Item.pinchPhoto(_:)))
        self.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(Item.rotateItem(_:)))
        rotateGesture.delegate = self
        self.addGestureRecognizer(rotateGesture)
    }
    func onPan(_ panGesture: UIPanGestureRecognizer) // viết func
    {
        if (panGesture.state == .began || panGesture.state == .changed) // (6 trạng thái chỉ quan tâm đến 2 trạng thái chính bắt đầu tab và thay đổi)
        {
            let point = panGesture.location(in: self.superview) // lấy ra tọa độ của điểm tab so vs view ngoài
            self.center = point; //gán tọa độ vừa lấy ( di chuyển cái icon đến điểm đó)
            
        }
        
    }
    func pinchPhoto(_ pinchGestrureRecognizer: UIPinchGestureRecognizer) // phóng to thu nhỏ của icon to nhỏ
    {
        //        self.adjustAnchorPointForGestureRecognizer(pinchGestrureRecognizer)
        if let view = pinchGestrureRecognizer.view // lấy ra cái view mà ta tab vào if let  để chắc nó ko nil
        {
            view.transform = view.transform.scaledBy(x: pinchGestrureRecognizer.scale, y: pinchGestrureRecognizer.scale) // kiểu CGAvartransform
            pinchGestrureRecognizer.scale = 1 // set lại để kích cỡ không bị điều chỉnh quá nhiều
        }
    }
    func rotateItem(_ rotateGestureRecognizer: UIRotationGestureRecognizer) // xoay ảnh
    {
        //        self.adjustAnchorPointForGestureRecognizer(rotateGestureRecognizer)
        if let view = rotateGestureRecognizer.view // lấy ra cái view mà ta tab vào if let  để chắc nó ko nil
        {
            view.transform = view.transform.rotated(by: rotateGestureRecognizer.rotation)
            rotateGestureRecognizer.rotation = 0
        }
        
    }
    func adjustAnchorPointForGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) // cái này k biết làm j
    {
        if (gestureRecognizer.state == .began)
        {
            let locationInCurrentView = gestureRecognizer.location(in: gestureRecognizer.view)
            let locationInSuperView = gestureRecognizer.location(in: gestureRecognizer.view!.superview)
            self.layer.anchorPoint = CGPoint(x: locationInCurrentView.x / gestureRecognizer.view!.bounds.size.width, y: locationInCurrentView.y / gestureRecognizer.view!.bounds.size.height)
            self.center = locationInSuperView
        }
    }
}
extension Item: UIGestureRecognizerDelegate // đoạn code này để cho cái  rotateGesture.delegate = self ko báo lỗi
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}//end
