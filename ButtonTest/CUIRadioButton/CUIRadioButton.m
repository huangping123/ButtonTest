#import "CUIRadioButton.h"


@interface CUIRadioButton()
-(void) setDefaultValue;
@end


@implementation CUIRadioButton
static NSMutableDictionary *_groupRadioDic = nil;

- (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage
{
    [self setImage:checkedImage forState:UIControlStateSelected];
    [self setImage:checkedImage forState:UIControlStateHighlighted];
    [self setImage:uncheckedImage forState:UIControlStateNormal];

}

- (void) setcheckedTitle:(NSString *)checkedTitle uncheckedTitle:(NSString *)uncheckedTitle
{
    [self setTitle:checkedTitle forState:UIControlStateSelected];
    [self setTitle:checkedTitle forState:UIControlStateHighlighted];
    [self setTitle:uncheckedTitle forState:UIControlStateNormal];

}

- (void) setcheckedTitleColor:(UIColor *)checkedTitleColor uncheckedTitleColor:(UIColor *)uncheckedTitleColor
{
    [self setTitleColor:checkedTitleColor forState:UIControlStateSelected];
    [self setTitleColor:checkedTitleColor forState:UIControlStateHighlighted];
    [self setTitleColor:uncheckedTitleColor forState:UIControlStateNormal];
}

+ (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage withGroupId:(NSString*) groupId
{
    if(!_groupRadioDic)
    {
        return;
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:groupId];
    
    if(_gRadios)
    {
        for(CUIRadioButton *radioButton in _gRadios)
        {
            [radioButton setcheckedImage:checkedImage uncheckedImage:uncheckedImage];
        }
    }
}

+ (void) setcheckedTitle:(NSString *)checkedTitle uncheckedTitle:(NSString *)uncheckedTitle withGroupId:(NSString*) groupId
{
    if(!_groupRadioDic)
    {
        return;
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:groupId];
    
    if(_gRadios)
    {
        for(CUIRadioButton *radioButton in _gRadios)
        {
            [radioButton setcheckedTitle:checkedTitle uncheckedTitle:uncheckedTitle];
        }
    }

}

+ (void) setcheckedTitleColor:(UIColor *)checkedTitleColor uncheckedTitleColor:(UIColor *)uncheckedTitleColor withGroupId:(NSString*) groupId
{
    if(!_groupRadioDic)
    {
        return;
    }
    
    NSMutableArray *_gRadios = [_groupRadioDic objectForKey:groupId];
    
    if(_gRadios)
    {
        for(CUIRadioButton *radioButton in _gRadios)
        {
            [radioButton setcheckedTitleColor:checkedTitleColor uncheckedTitleColor:uncheckedTitleColor];

        }
    }


}

-(void) setDefaultValue
{
    self.exclusiveTouch = YES;
    self.selected = NO;
    [self addTarget:self action:@selector(radioButtonCheckedTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
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

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setDefaultValue];
    
    }
    return self;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setDefaultValue];
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
        for (CUIRadioButton *_radio in _gRadios) {
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
- (void)radioButtonCheckedTouchUpInside {
    
    if(_checked)
    {
        return;
    
    }
    self.checked = YES;
}
- (void)dealloc {
    [self removeFromGroup];
    
}


@end
