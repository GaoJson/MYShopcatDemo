//
//  WTShopcatHeadView.m
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "WTShopcatHeadView.h"
#import "Masonry.h"
@implementation WTShopcatHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithBaseView];
    }
    return self;
}

- (void)initWithBaseView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 0, screen_width, 50);
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.selectBtn];

    [self.selectBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [self.selectBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
    self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    self.shopName = [[UILabel alloc] init];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
       make.left.equalTo(self.contentView).offset(60);
        make.height.mas_equalTo(30);
      ;
    }];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleteBtn];
    [deleteBtn setImage:IMG(@"shopcat_delete") forState:UIControlStateNormal];
     deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [deleteBtn addTarget:self action:@selector(deleteSectionAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
}

- (void)deleteSectionAction {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(WTShopcatHeadViewDeleteCurrectSectionsInView:)]) {
        [self.delegate WTShopcatHeadViewDeleteCurrectSectionsInView:self.section];
    }
}

- (void)selectAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(WTShopcatHeadViewCurrectSectionsInView:selectStatus:)]) {
        [self.delegate WTShopcatHeadViewCurrectSectionsInView:self.section selectStatus:button.selected];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
