//
//  WTShopcatModel.h
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WTShopcatModel : NSObject
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, strong) NSMutableArray *productArray;
@end

@interface WTShopcatProductModel : NSObject
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, assign) CGFloat productPrice;

@end