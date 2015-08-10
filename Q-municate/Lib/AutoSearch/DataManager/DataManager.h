//
//  DataManager.h
//  NHAutoCompleteTextBox
//
//  Created by Shahan on 14/12/2014.
//  Copyright (c) 2014 Shahan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
{
    
}

@property (nonatomic, retain) NSMutableArray * dataSource;

-(id)fetchDataSynchronously;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com