//
//  RatingControl.h
//  RatingControl
//


#import <UIKit/UIKit.h>

@protocol RatingControlDelegate;

@interface RatingControl : UIControl
{
	UIImage *_emptyImage, *_solidImage;
    UIColor *_emptyColor, *_solidColor;
    NSInteger _maxRating;
}


/**************************************************************************************************/
#pragma mark - Getters and Setters
@property (weak,nonatomic) id<RatingControlDelegate> delegate;
@property (nonatomic) NSInteger rating;
@property (nonatomic) CGSize imageSize;
@property (nonatomic) float imageInterval;


/**************************************************************************************************/
#pragma mark - Birth & Death

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param maxRating
 */


- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating;

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param emptyColor & solidColor
 * @param maxRating
 */
- (id)initWithLocation:(CGPoint)location
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
          andMaxRating:(NSInteger)maxRating;

/**
 * @param location : position of the rating control in your view
 * The control will manage its own width/height (kind of like UIActivityIndicator)
 * @param emptyImage & solidImage can both be nil, or not even a dot or a star (a any images you want!)
 * If either of these parameters are nil, the class will draw its own stars
 * @param maxRating
 */
- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
          andMaxRating:(NSInteger)maxRating;


- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
             imageSize:(CGSize) imageSize
         imageInterval:(float) imageInterval
          andMaxRating:(NSInteger)maxRating;

- (id)initWithLocation:(CGPoint)location
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
             imageSize:(CGSize) imageSize
         imageInterval:(float) imageInterval
          andMaxRating:(NSInteger)maxRating;


@end

@protocol RatingControlDelegate <NSObject>

@optional


//rating正在改变
-(void) ratingControl:(RatingControl *)ratingControl changedRating:(NSInteger)rating;

//rating停止改变
-(void) ratingControl:(RatingControl *)ratingControl endChangingRating:(NSInteger)rating;


@end
