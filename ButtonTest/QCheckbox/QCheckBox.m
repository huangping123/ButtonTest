//
//  EICheckBox.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "QCheckBox.h"

#define Q_CHECK_ICON_WH                    (15.0)
#define Q_ICON_TITLE_MARGIN                (15.0)
#define Q_ICON_X                           (15.0)


@interface QCheckBox()

-(void) setDefaultValue;

@end

@implementation QCheckBox

-(void) setDefaultValue
{
    self.exclusiveTouch = YES;
    [self setImage:[UIImage imageNamed:@"cb_box_off.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"cb_box_on.png"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        NSLog(@"QcheckBox initWithCoder");
        [self setDefaultValue];
    
    }
    
    return self;

}

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        [self setDefaultValue];
    }
    return self;
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_ICON_X, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN+Q_ICON_X, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN-Q_ICON_X,
                      CGRectGetHeight(contentRect));
}
 

- (void)dealloc {
}

@end
