//
//  PurchaseManager.swift
//  In App Purchase
//
//  Created by Kerem Demir on 3.05.2024.
//

import Foundation
import StoreKit

final class PurchaseManager: NSObject, SKProductsRequestDelegate ,SKPaymentTransactionObserver{
    
    // MARK: Singleton
    static let shared = PurchaseManager()
    
    var products = [SKProduct]()
    
    private var completion: ((Int) -> Void)?
    
    public func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    // MARK: Functions
    public func purchase(product: Product, completion: @escaping((Int) -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        self.completion = completion 
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    // MARK: Delegate Methods
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Product Returned : \(response.products.count)")
        
        self.products = response.products
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach ({
            
            switch $0.transactionState {
            case .purchasing:
                print("Purchasing")
            case .purchased:
                if let product = Product(rawValue: $0.payment.productIdentifier) {
                    completion?(product.count)
                }
                
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                
                print("Purchased")
            case .failed:
                print("Failed")
            case .restored:
                print("Restored")
            case .deferred:
                print("Deferred")
            @unknown default:
                break
            }
        })
    }
}
