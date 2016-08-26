//
//  WTShopcatCell.h
//  WeiTuoApp
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTShopcatCellDelegate <NSObject>

@optional
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag;
- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath;
@end

static NSString * const WTShopcatCells = @"WTShopcatCell";
@interface WTShopcatCell : UITableViewCell

@property (assign ,nonatomic) id<WTShopcatCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIView *addView;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *rpoductImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *delectBtn;

@property (weak, nonatomic) IBOutlet UITextField *conutText;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@end
