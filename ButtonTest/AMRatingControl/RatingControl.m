//
//  RatingControl.m
//  RatingControl
//


#import "RatingControl.h"


// Constants :
static const CGFloat kFontSize = 20;
static const NSInteger kStarWidthAndHeight = 20;

static const NSString *kDefaultEmptyChar = @"☆";
static const NSString *kDefaultSolidChar = @"★";


@interface RatingControl ()

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
             imageSize:(CGSize) imageSize
            imageInterval:(float) imageInterval
          andMaxRating:(NSInteger)maxRating;



- (void)handleTouch:(UITouch *)touch;

@end


@implementation RatingControl


/**************************************************************************************************/
#pragma mark - Getters & Setters

@synthesize rating = _rating;
- (void)setRating:(NSInteger)rating
{
    _rating = (rating < 0) ? 0 : rating;
    _rating = (rating > _maxRating) ? _maxRating : rating;
    [self setNeedsDisplay];
}


/**************************************************************************************************/
#pragma mark - Birth & Death

- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating
{
    return [self initWithLocation:location
                       emptyImage:nil
                       solidImage:nil
                       emptyColor:nil
                       solidColor:nil
                       imageSize:CGSizeMake(kStarWidthAndHeight, kStarWidthAndHeight)
                       imageInterval:0
                       andMaxRating:maxRating];
}

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
          andMaxRating:(NSInteger)maxRating
{
	return [self initWithLocation:location
                       emptyImage:emptyImageOrNil
                       solidImage:solidImageOrNil
                       emptyColor:nil
                       solidColor:nil
                       imageSize:CGSizeMake(kStarWidthAndHeight, kStarWidthAndHeight)
                       imageInterval:0
                       andMaxRating:maxRating];
}



- (id)initWithLocation:(CGPoint)location
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
          andMaxRating:(NSInteger)maxRating
{
    return [self initWithLocation:location
                       emptyImage:nil
                       solidImage:nil
                       emptyColor:emptyColor
                       solidColor:solidColor
                       imageSize:CGSizeMake(kStarWidthAndHeight, kStarWidthAndHeight)
                       imageInterval:0
                       andMaxRating:maxRating];
}

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
             imageSize:(CGSize) imageSize
         imageInterval:(float) imageInterval
          andMaxRating:(NSInteger)maxRating
{
    return [self initWithLocation:location
                       emptyImage:emptyImageOrNil
                       solidImage:solidImageOrNil
                       emptyColor:nil
                       solidColor:nil
                        imageSize:imageSize
                    imageInterval:imageInterval
                     andMaxRating:maxRating];


}

- (id)initWithLocation:(CGPoint)location
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
             imageSize:(CGSize) imageSize
         imageInterval:(float) imageInterval
          andMaxRating:(NSInteger)maxRating
{
    return [self initWithLocation:location
                       emptyImage:nil
                       solidImage:nil
                       emptyColor:emptyColor
                       solidColor:solidColor
                        imageSize:imageSize
                    imageInterval:imageInterval
                     andMaxRating:maxRating];

}


- (void)dealloc
{
	_emptyImage = nil,
	_solidImage = nil;
    _emptyColor = nil;
    _solidColor = nil;
}


/**************************************************************************************************/
#pragma mark - View Lifecycle

- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
	CGPoint currPoint = CGPointZero;
	
	for (int i = 0; i < _rating; i++)
	{
		if (_solidImage)
        {
            NSLog(@"_solidImage");
              [_solidImage drawInRect:CGRectMake(currPoint.x, currPoint.y, _imageSize.width, _imageSize.height)];
        }
		else
        {
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _solidColor.CGColor);
            [kDefaultSolidChar drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:kFontSize]];
        }
			
		currPoint.x += _imageSize.width + _imageInterval;
	}
	
	NSInteger remaining = _maxRating - _rating;
	
	for (int i = 0; i < remaining; i++)
	{
		if (_emptyImage)
        {
			[_emptyImage drawInRect:CGRectMake(currPoint.x, currPoint.y, _imageSize.width, _imageSize.height)];
        }
		else
        {
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _emptyColor.CGColor);
			[kDefaultEmptyChar drawAtPoint:currPoint withFont:[UIFont boldSystemFontOfSize:kFontSize]];
        }
        NSLog(@"%f",currPoint.x);
		currPoint.x += _imageSize.width + _imageInterval;
	}
}


/**************************************************************************************************/
#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"beginTrackingWithTouch");
	[self handleTouch:touch];
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"continueTrackingWithTouch");

	[self handleTouch:touch];
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
    
    if([self.delegate respondsToSelector:@selector(ratingControl:endChangingRating:)])
    {
        [_delegate ratingControl:self endChangingRating:_rating];
    }
    
}


/**************************************************************************************************/
#pragma mark - Private Methods

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _imageSize = CGSizeMake(20.0, 20.0);
        _imageInterval = 0.0;
   }
    return self;
}

- (id)initWithLocation:(CGPoint)location
            emptyImage:(UIImage *)emptyImageOrNil
            solidImage:(UIImage *)solidImageOrNil
            emptyColor:(UIColor *)emptyColor
            solidColor:(UIColor *)solidColor
            imageSize:(CGSize) imageSize
            imageInterval:(float) imageInterval
            andMaxRating:(NSInteger)maxRating
{

    if (self = [self initWithFrame:CGRectMake(location.x,
                                              location.y,
                                              (maxRating * imageSize.width)+(maxRating-1)*imageInterval,
                                              imageSize.height)])
	{
       // NSLog(@"(id)initWithLocation:(CGPoint)location %@",emptyImageOrNil);
        
		_rating = 0;
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		_emptyImage = emptyImageOrNil;
		_solidImage = solidImageOrNil;
        _emptyColor = emptyColor;
        _solidColor = solidColor;
        _maxRating = maxRating;
        _imageSize = imageSize;
        _imageInterval = imageInterval;
	}
	
	return self;
}





- (void)handleTouch:(UITouch *)touch
{
    CGFloat width = self.frame.size.width;
	CGRect section = CGRectMake(0, 0, ((width-(_maxRating-1)*_imageInterval) / _maxRating), self.frame.size.height);
	
	CGPoint touchLocation = [touch locationInView:self];
	
	if (touchLocation.x < 0)
	{
		if (_rating != 0)
		{
			_rating = 0;
			[self sendActionsForControlEvents:UIControlEventEditingChanged];
            if([_delegate respondsToSelector:@selector(ratingControl:changedRating:)])
            {
                [_delegate ratingControl:self changedRating:_rating];
            
            
            }
		}
	}
	else if (touchLocation.x > width)
	{
		if (_rating != _maxRating)
		{
			_rating = _maxRating;
			[self sendActionsForControlEvents:UIControlEventEditingChanged];
            if([_delegate respondsToSelector:@selector(ratingControl:changedRating:)])
            {
                [_delegate ratingControl:self changedRating:_rating];
                
                
            }
		}
	}
	else
	{
		for (int i = 0 ; i < _maxRating ; i++)
		{
            NSLog(@"x = %f %f %f",touchLocation.x,section.origin.x,section.size.width);
			if ((touchLocation.x > section.origin.x) && (touchLocation.x < (section.origin.x + section.size.width)))
			{
				if (_rating != (i+1))
				{
					_rating = i+1;
					[self sendActionsForControlEvents:UIControlEventEditingChanged];
                    if([_delegate respondsToSelector:@selector(ratingControl:changedRating:)])
                    {
                        [_delegate ratingControl:self changedRating:_rating];
                        
                        
                    }
				}
				break;
			}
			section.origin.x += section.size.width+_imageInterval;
		}
        NSLog(@"rating %d",_rating);

	}
	[self setNeedsDisplay];
}

@end


