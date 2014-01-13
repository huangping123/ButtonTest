//
//  CUIDropDownList.h
//  ButtonTest
//
//  Created by jianglinjie on 13-11-13.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PopUp,
    PopDown,
}PopDirection;

typedef enum
{
    Closed = 0,
    Expanding = 1,
    Expanded = 2,
    Closing =3,
}DrowDownState;

@protocol CUIDropDownListDelegate;
@class CUICheckBox;

@interface CUIDropDownList : UIView
@property (nonatomic ,assign) DrowDownState state;     //Default Closed
@property (nonatomic, assign) BOOL needHeaderView;     //Default NO
@property (nonatomic, assign) BOOL needmiddleAnimation;//Default NO
@property (nonatomic, assign) BOOL needBackCover;      //Default NO
@property (nonatomic, assign) BOOL shouldAutoDismiss;  //Default NO
@property (nonatomic, assign) PopDirection direction; //Default PopDown
@property (nonatomic ,assign) BOOL shouldAnimation;   //Default YES
@property (nonatomic ,assign) CGFloat autoDismissInterval;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSUInteger preselectedIndex;
@property (nonatomic, assign) CGFloat expandedInterval;
@property (nonatomic, assign) CGFloat closedInterval;
@property (nonatomic, assign) CGFloat middleInterval;


@property (nonatomic, weak) id<CUIDropDownListDelegate> delegate;
@property (strong,nonatomic) UITableView *tableView;


-(id) initWithDelegate:(id<CUIDropDownListDelegate>) delegate;
-(void) setDisplayView:(UIView *)view;
-(void) setSelectedIndex:(NSUInteger)selectedIndex;
-(void) reloadData;
-(void) expandListwithCompletionBlock:(void (^)())completion;
-(void) closeListwithCompletionBlock:(void (^)())completion;
@end

@protocol CUIDropDownListDelegate <NSObject>
@required
- (NSInteger)numberOfElementsInDropDownList:(CUIDropDownList *)dropDownList;
- (UITableViewCell *)dropDownList:(CUIDropDownList *)dropDownList cellForElementAtIndex:(NSUInteger)index;

@optional
- (void)dropDownList:(CUIDropDownList *)dropDownList didSelectElementAtIndexPath:(NSUInteger)index;

- (CGFloat)dropDownList:(CUIDropDownList *)dropDownList heightForElementAtIndex:(NSUInteger)index;
- (CGFloat)heightOfHeaderViewIndropDownList:(CUIDropDownList *)dropDownList;
- (UIView*)HeaderViewOfdropDownList:(CUIDropDownList *)dropDownList;

-(CGFloat)heightOfDropDownList:(CUIDropDownList *)dropDownList;
-(CGFloat)widthOfDropDownList: (CUIDropDownList *)dropDownList;
-(CGPoint)popPointOfDropDownList:(CUIDropDownList *)dropDownList;
@end
