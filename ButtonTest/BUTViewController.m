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


@interface BUTViewController ()
@property (weak, nonatomic) IBOutlet  CUIRatingControl*ratingControl;

@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton1;
@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton2;
@property (weak, nonatomic) IBOutlet CUIRadioButton *QRadioButton3;





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
    
    //类似于淘宝评分
    _ratingControl.imageInterval = 10;
    _ratingControl.imageSize = CGSizeMake(30, 30);
    _ratingControl.startLocation = CGPointMake(30, 10);
    _ratingControl.solidImage = [UIImage imageNamed:@"solidstar.png"];
    _ratingControl.emptyImage = [UIImage imageNamed:@"emptystar.png"];
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
