//
//  EICheckBox.h
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCheckBoxDelegate;

@interface QCheckBox : UIButton


@property(nonatomic, weak)id<QCheckBoxDelegate> delegate;
@property(nonatomic)BOOL checked;
@property(nonatomic, strong)id userInfo;



- (id)initWithDelegate:(id)delegate;
- (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage;

@end

@protocol QCheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked;

@end
