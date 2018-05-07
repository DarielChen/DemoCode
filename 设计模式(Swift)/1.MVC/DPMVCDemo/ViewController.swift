//
//  ViewController.swift
//  DPMVCDemo
//
//  Created by  Dariel on 2018/4/22.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    // MARK: - Properties
    public var address: Address? {
        didSet {
            updateViewFromAddress()
        }
    }
    
    public var addressView: AddressView! { // 关联view
        guard isViewLoaded else {
            return nil
        }
        return view as! AddressView
    }

    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateViewFromAddress() {
        
        if let address = address {
            addressView.addressLabel.text = "street: "+address.street+"\ncity: "+address.city+"\nstate: "+address.state+"\nzipCode: "+address.zipCode
        }else {
            addressView.addressLabel.text = "地址为空"
        }
    }
    
    // MARK: - Actions
    @IBAction public func updateAddressFromView(_ sender: AnyObject) {
        
        guard let street = addressView.streetTextField.text, street.count > 0,
            let city = addressView.cityTextField.text, city.count > 0,
            let state = addressView.stateTextField.text, state.count > 0,
            let zipCode = addressView.zipCodeTextField.text, zipCode.count > 0
            else {
                return
        }
        address = Address(street: street, city: city,
                          state: state, zipCode: zipCode)
    }
    
    @IBAction func clearAddressFromView(_ sender: Any) {
        
        address = nil
    }
}

