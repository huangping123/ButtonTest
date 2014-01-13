//
//  RatingControl.h
//  RatingControl
//


#import <UIKit/UIKit.h>

@protocol CUIRatingControlDelegate;

@interface CUIRatingControl : UIButton

@property (weak,nonatomic) id<CUIRatingControlDelegate> delegate;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger maxRating;
@property (nonatomic) CGPoint startLocation;
@property (nonatomic) CGSize imageSize;
@property (nonatomic) CGFloat imageInterval;
@property (strong, nonatomic) UIImage *emptyImage;
@property (strong, nonatomic) UIImage *solidImage;
@property (strong, nonatomic) UIColor *emptyColor;
@property (strong, nonatomic) UIColor *solidColor;



- (id)initWithStartLocation:(CGPoint)startLocation
                 EmptyImage:(UIImage *)emptyImageOrNil
                 SolidImage:(UIImage *)solidImageOrNil
                 EmptyColor:(UIColor *)emptyColor
                 SolidColor:(UIColor *)solidColor
                  ImageSize:(CGSize) imageSize
              ImageInterval:(CGFloat) imageInterval
                  MaxRating:(NSInteger)maxRating
                      Frame:(CGRect) frame;


@end

@protocol CUIRatingControlDelegate <NSObject>
@optional
-(void) ratingControl:(CUIRatingControl *)ratingControl changedRating:(NSInteger)rating;
-(void) ratingControl:(CUIRatingControl *)ratingControl endChangingRating:(NSInteger)rating;
@end
