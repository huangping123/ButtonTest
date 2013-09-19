//
//  BUTViewController.m
//  ButtonTest
//
//  Created by linjie jiang on 13-9-18.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "BUTViewController.h"
#import "QRadioButton.h"
#import "QCheckBox.h"
#import "RatingControl.h"
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
- (IBAction)touchDownTest:(id)sender;

- (IBAction)touchUpInside:(id)sender;

- (IBAction)touchUpOutside:(id)sender;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton1;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton2;
@property (weak, nonatomic) IBOutlet QRadioButton *QRadioButton3;

@property (weak, nonatomic) IBOutlet  QCheckBox *testEventButton;

- (IBAction)getInfoButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ratingViewContainer;


@end

@implementation BUTViewController
NSString *const testGroupID = @"testGroupID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.QRadioButton1.groupId = testGroupID;
    self.QRadioButton2.groupId = testGroupID;
    self.QRadioButton3.groupId = testGroupID;
    
    
    CGRect bound = _testEventButton.bounds;
    
    _testEventButton.imageEdgeInsets = UIEdgeInsetsMake((bound.size.height-BUTTON_IMAGE_H)/2, BUTTON_IMAGE_INSET_LEFT, (bound.size.height-BUTTON_IMAGE_H)/2, bound.size.width - BUTTON_IMAGE_INSET_LEFT - BUTTON_IMAGE_W);
    
    
    _testEventButton.titleEdgeInsets = UIEdgeInsetsMake((bound.size.height-BUTTON_IMAGE_H)/2, BUTTON_TITLE_MARGIN + BUTTON_IMAGE_INSET_LEFT + BUTTON_IMAGE_W, (bound.size.height-BUTTON_IMAGE_H)/2, BUTTON_IMAGE_INSET_RIGHT);
    

    RatingControl *control = [[RatingControl alloc] initWithLocation:CGPointZero emptyImage:[UIImage imageNamed:@"036-vote-star-2.png"] solidImage:[UIImage imageNamed:@"035-vote-star-1.png"] imageSize:CGSizeMake(28,28) imageInterval:14 andMaxRating:5];
     
    /*
    RatingControl *control = [[RatingControl alloc] initWithLocation:CGPointZero emptyImage:[UIImage imageNamed:@"036-vote-star-2.png"] solidImage:[UIImage imageNamed:@"036-vote-star-1.png"] andMaxRating:5];
    */
    [self.ratingViewContainer addSubview:control];
    [control setNeedsDisplay];
    
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

-(void) printRect:(CGRect)rect
{
    NSLog(@"x= %f y = %f width = %f height = %f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}

- (IBAction)getInfoButtonPressed:(id)sender {
    NSLog(@"%@",_testEventButton);
    
    
    
}
@end
