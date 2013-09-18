//
//  BUTViewController.m
//  ButtonTest
//
//  Created by linjie jiang on 13-9-18.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "BUTViewController.h"
#import "QRadioButton.h"

@interface BUTViewController ()
- (IBAction)touchDownTest:(id)sender;

- (IBAction)touchUpInside:(id)sender;

- (IBAction)touchUpOutside:(id)sender;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton1;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton2;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton3;

@property (weak, nonatomic) IBOutlet UIButton *testEventButton;



@end

@implementation BUTViewController
NSString *const testGroupID = @"testGroupID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.QRadioButton1.groupId = testGroupID;
    self.QRadioButton2.groupId = testGroupID;
    self.QRadioButton3.groupId = testGroupID;

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDownTest:(id)sender {
    NSLog(@"touchDownTest");
    NSLog(@"%d",self.testEventButton.state);
}

- (IBAction)touchUpInside:(id)sender {
    NSLog(@"touchUpInside");
    NSLog(@"%d",self.testEventButton.state);

}

- (IBAction)touchUpOutside:(id)sender {
    NSLog(@"touchUpOutside");
    NSLog(@"%d",self.testEventButton.state);

}
@end
