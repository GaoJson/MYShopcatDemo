//
//  WTShopcatCell.m
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "WTShopcatCell.h"

@implementation WTShopcatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addView.layer.borderWidth = 1;
    self.addView.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    self.addView.layer.cornerRadius = 5;
    self.addView.layer.masksToBounds = YES;
    self.conutText.layer.borderWidth = 0.5;
    self.conutText.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    [self.selectBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [self.selectBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
}

- (IBAction)selectProductAction:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectProductActionWithIndex:selectFlag:)]) {
        [self.delegate selectProductActionWithIndex:self.indexPath selectFlag:button.selected];
    }
}

- (IBAction)addProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addProductCountActionWithIndex:)]) {
        [self.delegate addProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)subProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(subProductCountActionWithIndex:)]) {
        [self.delegate subProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)deleteProductAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteProductActionWithIndex:)]) {
        [self.delegate deleteProductActionWithIndex:self.indexPath];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
