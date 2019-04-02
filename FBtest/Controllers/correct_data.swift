//
//  correct_data.swift
//  FBtest
//
//  Created by Sreejith Thrivikraman on 2018-08-01.
//  Copyright © 2018 robin. All rights reserved.
//

import Foundation


//class saved_data
//{
//    var data = [String]();
//
//    func getData(element : String)
//    {
//        self.data.append(element);
//    }
//
//
//    func deleteData(element : String)
//    {
//        self.data = [];
//    }
//
//    func displayData()
//    {
//        for i in data
//        {
//            print(data)
//        }
//    }
//}


protocol saved_data
{
    func didFetchData(data:[String])
}
