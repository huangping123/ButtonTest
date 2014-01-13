//
//  CUIDropDowListCell.m
//  ButtonTest
//
//  Created by jianglinjie on 13-11-19.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "CUIDropDowListCell.h"

@implementation CUIDropDowListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    if(selected)
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        self.accessoryType = UITableViewCellAccessoryNone;

    // Configure the view for the selected state
}

@end
