#import "CUICheckBox.h"

#define Q_CHECK_ICON_WH                    (15.0)
#define Q_ICON_TITLE_MARGIN                (15.0)
#define Q_ICON_X                           (15.0)


@interface CUICheckBox()



-(void) setDefaultValue;


@end

@implementation CUICheckBox


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
- (void) setcheckedTitleColor:(UIColor *)checkedColor uncheckedTitleColor:(UIColor *)unheckedColor
{
    [self setTitleColor:checkedColor forState:UIControlStateSelected];
    [self setTitleColor:checkedColor forState:UIControlStateHighlighted];
    [self setTitleColor:unheckedColor forState:UIControlStateNormal];
}

-(void) setDefaultValue
{
    self.exclusiveTouch = YES;
    self.selected = NO;
    [self addTarget:self action:@selector(checkboxButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
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
}

- (void)checkboxButtonTouchUpInside {
    self.checked = !self.checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)dealloc {
}

@end
