//
//  CUIDropDownList.h
//  ButtonTest
//
//  Created by jianglinjie on 13-11-13.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CUIDropDownListDelegate;
@class CUICheckBox;

@interface CUIDropDownList : UIView

@property (nonatomic, getter = isExpanded) BOOL expanded;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic,assign) CGFloat listHeight;
@property (nonatomic,assign) id<CUIDropDownListDelegate> delegate;

@property (strong,nonatomic,readonly) UITableView *tableView;
@property (strong,nonatomic,readonly) CUICheckBox *button;


-(void) setSelectedIndex:(NSUInteger)selectedIndex;
-(void) reloadData;
@end

@protocol CUIDropDownListDelegate <NSObject>
@required
- (NSInteger)numberOfElementsInDropDownList:(CUIDropDownList *)dropDownList;
- (UITableViewCell *)dropDownList:(CUIDropDownList *)dropDownList cellForElementAtIndex:(NSUInteger)index isSelected:(BOOL) isSelected;

@optional
- (CGFloat)dropDownList:(CUIDropDownList *)dropDownList heightForElementAtIndex:(NSUInteger)index;
- (void)dropDownList:(CUIDropDownList *)dropDownList didSelectElementAtIndexPath:(NSUInteger)index;

-(CGFloat)heightOfDropDownList:(CUIDropDownList *)dropDownList;
-(CGFloat)widthOfDropDownList:(CUIDropDownList *)dropDownList;

@end
