//
//  WTShopcatHeadView.h
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTShopcatHeadViewDelegate <NSObject>
@optional
- (void)WTShopcatHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus;

- (void)WTShopcatHeadViewDeleteCurrectSectionsInView:(NSInteger)section;

@end

static NSString * const WTShopcatHeadViews = @"WTShopcatHeadView";

@interface WTShopcatHeadView : UITableViewHeaderFooterView

@property (nonatomic, assign) id<WTShopcatHeadViewDelegate> delegate;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, assign) NSInteger section;
@end
