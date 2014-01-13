//
//  BUTViewController.m
//  ButtonTest
//
//  Created by linjie jiang on 13-9-18.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "BUTViewController.h"
#import "CUIRadioButton.h"
#import "CUICheckBox.h"
#import "CUIRatingControl.h"
#import "CUIDropDownList.h"
#import "CUIDropDowListCell.h"


#define BUTTON_IMAGE_W (22)
#define BUTTON_IMAGE_H (22)


#define BUTTON_IMAGE_INSET_TOP 5
#define BUTTON_IMAGE_INSET_BUTTOM 5
#define BUTTON_IMAGE_INSET_LEFT 5
#define BUTTON_IMAGE_INSET_RIGHT 5

#define BUTTON_TITLE_MARGIN 10

#define BUTTON_TITLE_INSET_TOP 5
#define BUTTON_TITLE_INSET_BUTTOM 5
#define BUTTON_TITLE_INSET_LEFT 5
#define BUTTON_TITLE_INSET_BUTTOM 5


@interface BUTViewController ()<CUIDropDownListDelegate>
@property (weak, nonatomic) IBOutlet  CUIRatingControl*ratingControl;

@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton1;
@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton2;
@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton3;

@property (strong, nonatomic) IBOutlet CUIDropDownList *dropDownList;




@property (weak, nonatomic) IBOutlet CUICheckBox *checkBox;
@end

@implementation BUTViewController
NSString *const testGroupID = @"testGroupID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    //一组单选按钮
    self.QRadioButton1.groupId = testGroupID;
    self.QRadioButton2.groupId = testGroupID;
    self.QRadioButton3.groupId = testGroupID;
    [CUIRadioButton setcheckedImage:[UIImage imageNamed:@"radio_checked.png"] uncheckedImage:[UIImage imageNamed:@"radio_unchecked.png"] withGroupId:testGroupID];
    
    //复选框
    [_checkBox setcheckedImage:[UIImage imageNamed:@"checkbox_checked.png"] uncheckedImage:[UIImage imageNamed:@"checkbox_unchecked.png"]];
    [_checkBox addTarget:self action:@selector(dropDown:) forControlEvents:UIControlEventTouchUpInside];
    
    //类似于淘宝评分
    _ratingControl.imageInterval = 10;
    _ratingControl.imageSize = CGSizeMake(30, 30);
    _ratingControl.startLocation = CGPointMake(30, 10);
    _ratingControl.solidImage = [UIImage imageNamed:@"solidstar.png"];
    _ratingControl.emptyImage = [UIImage imageNamed:@"emptystar.png"];
    
    

    
    _dropDownList = [[CUIDropDownList alloc] initWithFrame:CGRectMake(100, 20, 120, 44)];
    _dropDownList.delegate = self;
    [_dropDownList setDisplayView:self.view];
    [_dropDownList reloadData];
    [_dropDownList setSelectedIndex:0];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dropDown:(id)sender
{
    if(![_checkBox checked])
    {
        [_dropDownList closeListwithCompletionBlock:^{
            //[_checkBox setChecked:YES];
        
        }];
    
    
    }
    else
    {
        [_dropDownList expandListwithCompletionBlock:^{
           // [_checkBox setChecked:NO];
            
        }];
    
    
    }
    
    
    

}

- (NSInteger)numberOfElementsInDropDownList:(CUIDropDownList *)dropDownList
{
    return 8;
}

- (UITableViewCell *)dropDownList:(CUIDropDownList *)dropDownList cellForElementAtIndex:(NSUInteger)index
{
    static NSString *cellIndentifier = @"cellIndentifier";
    
    CUIDropDowListCell *cell = [dropDownList.tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if(cell == nil)
    {
        cell = [[CUIDropDowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    
    }
    
    cell.textLabel.text = [[NSNumber numberWithInteger:index] stringValue];
    cell.title = cell.textLabel.text;

    return cell;
}

-(void) dropDownList:(CUIDropDownList *)dropDownList didSelectElementAtIndexPath:(NSUInteger)index
{
    [_dropDownList closeListwithCompletionBlock:^{
        //[_checkBox setChecked:YES];
        
    }];
}

- (CGFloat)dropDownList:(CUIDropDownList *)dropDownList heightForElementAtIndex:(NSUInteger)index
{
    return 30;
}

-(CGFloat)heightOfDropDownList:(CUIDropDownList *)dropDownList
{
    return 240;

}

-(CGFloat)widthOfDropDownList:(CUIDropDownList *)dropDownList
{
    return 240;


}

-(CGPoint)popPointOfDropDownList:(CUIDropDownList *)dropDownList
{
    return CGPointMake(0, 0);

}



@end
