//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/13.
//

import SwiftUI

struct FlyingNumber: View {
  let number: Int
  
    var body: some View {
      if number != 0 {
        Text(number, format: .number.sign(strategy: .always()))
          .font(.largeTitle)
          .foregroundColor(number < 0 ? .red : .blue)
          .shadow(color: .black, radius: 1.5, x: 1, y: 1)
      }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
      FlyingNumber(number: 5)
    }
}
