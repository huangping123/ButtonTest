//
//  EIRadioButton.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "QRadioButton.h"

#define Q_RADIO_ICON_WH                     (18.0)
#define Q_ICON_TITLE_MARGIN                 (5.0)
#define Q_ICON_X                            (0.0)

@interface QRadioButton()
-(void) setDefaultValue;
@end


@implementation QRadioButton
static NSMutableDictionary *_groupRadioDic = nil;

- (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage
{
    [self setImage:checkedImage forState:UIControlStateSelected];
    [self setImage:uncheckedImage forState:UIControlStateNormal];
    
}

-(void) setDefaultValue
{
    self.exclusiveTouch = YES;
    [self addTarget:self action:@selector(radioBtnCheckedTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder:aDecoder])
    {
        [self setDefaultValue];
    
    }
    return self;
}





- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _groupId = [groupId copy];
        
        [self addToGroup];
        
        [self setDefaultValue];
        

    }
    return self;
}

-(void) setGroupId:(NSString *)groupId
{
    [self removeFromGroup];
    _groupId = [groupId copy];
    [self addToGroup];
}



- (void)addToGroup {
    if(!_groupRadioDic){
        _groupRadioDic = [NSMutableDictionary dictionary] ;
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (!_gRadios) {
        _gRadios = [NSMutableArray array];
    }
    [_gRadios addObject:self];
    [_groupRadioDic setObject:_gRadios forKey:_groupId];
}

- (void)removeFromGroup {
    if (_groupRadioDic) {
        NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
        if (_gRadios) {
            [_gRadios removeObject:self];
            if (_gRadios.count == 0) {
                [_groupRadioDic removeObjectForKey:_groupId];
            }
        }
    }
}

- (void)uncheckOtherRadios {
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:_groupId];
    if (_gRadios.count > 0) {
        for (QRadioButton *_radio in _gRadios) {
            if (_radio.checked && ![_radio isEqual:self]) {
                _radio.checked = NO;
            }
        }
    }
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (self.selected) {
        [self uncheckOtherRadios];
    }
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        [_delegate didSelectedRadioButton:self groupId:_groupId];
    }
}
- (void)radioBtnCheckedTouchUpInside {
    
    NSLog(@"radioBtnCheckedTouchUpInside %d",self.selected);
    if(_checked)
    {
        return;
    
    }
    
    if(!self.selected)
    {
        self.selected = !self.selected;
    }
    
    self.checked = self.selected;
    
    if (self.selected) {
        [self uncheckOtherRadios];
    }
    
    if (self.selected && _delegate && [_delegate respondsToSelector:@selector(didSelectedRadioButton:groupId:)]) {
        [_delegate didSelectedRadioButton:self groupId:_groupId];
        
    }



}



/*
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_ICON_X, (CGRectGetHeight(contentRect) - Q_RADIO_ICON_WH)/2.0, Q_RADIO_ICON_WH, Q_RADIO_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_RADIO_ICON_WH + Q_ICON_TITLE_MARGIN+Q_ICON_X, 0,
                      CGRectGetWidth(contentRect) - Q_RADIO_ICON_WH - Q_ICON_TITLE_MARGIN-Q_ICON_X,
                      CGRectGetHeight(contentRect));
}
 

*/

- (void)dealloc {
    [self removeFromGroup];
    
}


@end
