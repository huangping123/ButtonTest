#import <UIKit/UIKit.h>

@protocol CUIRadioButtonDelegate;

@interface CUIRadioButton : UIButton

@property(nonatomic, weak) id<CUIRadioButtonDelegate>   delegate;
@property(nonatomic, copy) NSString *groupId;
@property(nonatomic) BOOL checked;

- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId;

- (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage;
- (void) setcheckedTitle:(NSString *)checkedTitle uncheckedTitle:(NSString *)uncheckedTitle;
- (void) setcheckedTitleColor:(UIColor *)checkedColor uncheckedTitleColor:(UIColor *)unheckedColor;


+ (void) setcheckedImage:(UIImage *)checkedImage uncheckedImage:(UIImage *)uncheckedImage withGroupId:(NSString*) groupId;
+ (void) setcheckedTitle:(NSString *)checkedTitle uncheckedTitle:(NSString *)uncheckedTitle withGroupId:(NSString*) groupId;
+ (void) setcheckedTitleColor:(UIColor *)checkedColor uncheckedTitleColor:(UIColor *)unheckedColor withGroupId:(NSString*) groupId;



@end

@protocol CUIRadioButtonDelegate <NSObject>

@optional

- (void)didSelectedRadioButton:(CUIRadioButton *)radio groupId:(NSString *)groupId;

@end
