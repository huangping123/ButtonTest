#import <UIKit/UIKit.h>

@protocol CUICheckBoxDelegate;

@interface CUICheckBox : UIButton


@property(nonatomic, weak)id<CUICheckBoxDelegate> delegate;
@property(nonatomic)BOOL checked;

- (id)initWithDelegate:(id)delegate;

- (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage;
- (void) setcheckedTitle:(NSString *)checkedTitle uncheckedTitle:(NSString *)uncheckedTitle;
- (void) setcheckedTitleColor:(UIColor *)checkedColor uncheckedTitleColor:(UIColor *)unheckedColor;

@end

@protocol CUICheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(CUICheckBox *)checkbox checked:(BOOL)checked;

@end
