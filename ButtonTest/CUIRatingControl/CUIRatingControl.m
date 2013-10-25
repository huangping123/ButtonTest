//
//  RatingControl.m
//  RatingControl
//


#import "CUIRatingControl.h"

#define DefaultStartLocation CGPointZero
#define DefaultEmptyColor [UIColor whiteColor]
#define DefaultSolidColor [UIColor blackColor]



static const CGFloat kFontSize = 20;
static const NSString *kDefaultEmptyChar = @"☆";
static const NSString *kDefaultSolidChar = @"★";
static const NSInteger kStarWidthAndHeight = 20;




@interface CUIRatingControl ()
- (void)handleTouch:(UITouch *)touch;
@end

@implementation CUIRatingControl


-(void) setDelegate:(id<CUIRatingControlDelegate>)delegate
{
    if(_delegate != delegate)
    {
        _delegate = delegate;
        [self setNeedsDisplay];
    }
}

- (void)setRating:(NSInteger)rating
{
    if(_rating != rating)
    {
        _rating = (rating < 0) ? 0 : rating;
        _rating = (rating > _maxRating) ? _maxRating : rating;
        [self setNeedsDisplay];
    }
}
-(void)setMaxRating:(NSInteger)maxRating
{
    if(_maxRating != maxRating)
    {
        _maxRating = maxRating;
        [self setNeedsDisplay];
    }
}

-(void)setStartLocation:(CGPoint)startLocation
{
    if(!CGPointEqualToPoint(_startLocation, startLocation))
    {
        _startLocation = startLocation;
        [self setNeedsDisplay];
    }
}

-(void) setImageSize:(CGSize)imageSize
{

    if(!CGSizeEqualToSize(_imageSize,imageSize))
    {
        _imageSize = imageSize;
        [self setNeedsDisplay];
    }
}

-(void) setImageInterval:(CGFloat)imageInterval
{
    if(_imageInterval != imageInterval)
    {
        _imageInterval = imageInterval;
        [self setNeedsDisplay];
    }
}

-(void) setSolidColor:(UIColor *)solidColor
{
    if(_solidColor != solidColor)
    {
        _solidColor = solidColor;
        [self setNeedsDisplay];
    }
}

-(void) setEmptyColor:(UIColor *)emptyColor
{
    if(_emptyColor != emptyColor)
    {
        _emptyColor = emptyColor;
        [self setNeedsDisplay];
    }
}

-(void) setSolidImage:(UIImage *)solidImage
{
    if(_solidImage != solidImage)
    {
        _solidImage = solidImage;
        [self setNeedsDisplay];
    }

}

-(void) setEmptyImage:(UIImage *)emptyImage
{
    if(_emptyImage != emptyImage)
    {
        _emptyImage = emptyImage;
        [self setNeedsDisplay];
    
    }
}



- (void)dealloc
{
}


- (void)drawRect:(CGRect)rect
{
	CGPoint currPoint = _startLocation;
	
	for (int i = 0; i < _rating; i++)
	{
		if (_solidImage)
        {
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
		currPoint.x += _imageSize.width + _imageInterval;
	}
}




- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self handleTouch:touch];
	return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self handleTouch:touch];
	return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(_delegate && [_delegate respondsToSelector:@selector(ratingControl:endChangingRating:)])
    {
        [_delegate ratingControl:self endChangingRating:_rating];
    }
    
    [super endTrackingWithTouch:touch withEvent:event];
    
}

-(void) setDefaultValue
{
    _emptyColor = DefaultEmptyColor;
    _solidColor = DefaultSolidColor;
    _startLocation = DefaultStartLocation;
    _imageInterval = 0;
    _imageSize = CGSizeMake(kStarWidthAndHeight, kStarWidthAndHeight);
    _rating = 0;
    _maxRating = 5;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setDefaultValue];
    }
    return  self;

}

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setDefaultValue];
    }
    
    [self setNeedsDisplay];
    return  self;
}



- (id)initWithStartLocation:(CGPoint)startLocation
            EmptyImage:(UIImage *)emptyImageOrNil
            SolidImage:(UIImage *)solidImageOrNil
            EmptyColor:(UIColor *)emptyColor
            SolidColor:(UIColor *)solidColor
             ImageSize:(CGSize) imageSize
         ImageInterval:(CGFloat) imageInterval
             MaxRating:(NSInteger)maxRating
                 Frame:(CGRect) frame
{

    if (self = [self initWithFrame:frame])
	{
        
		_rating = 0;
        _startLocation = startLocation;
		_emptyImage = emptyImageOrNil;
		_solidImage = solidImageOrNil;
        _emptyColor = emptyColor;
        _solidColor = solidColor;
        _imageSize = imageSize;
        _imageInterval = imageInterval;
        _maxRating = maxRating;

	}
    [self setNeedsDisplay];
	
	return self;
}


- (void)handleTouch:(UITouch *)touch
{
    CGFloat width = self.frame.size.width;
	CGRect currentsection = CGRectMake(_startLocation.x, 0, _imageInterval + _imageSize.width, self.frame.size.height);
	
	CGPoint touchLocation = [touch locationInView:self];
	
	if (touchLocation.x < currentsection.origin.x)
	{
		if (_rating != 0)
		{
			_rating = 0;
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
            if([_delegate respondsToSelector:@selector(ratingControl:changedRating:)])
            {
                [_delegate ratingControl:self changedRating:_rating];
                
                
            }
		}
	}
	else
	{
		for (int i = 1; i <= _maxRating ; i++)
		{
			if (((touchLocation.x >= currentsection.origin.x) && (touchLocation.x <= currentsection.origin.x+ currentsection.size.width)) || (i == _maxRating && touchLocation.x >= currentsection.origin.x))
			{
                if(_rating != i)
                {
                    _rating = i;
                    if([_delegate respondsToSelector:@selector(ratingControl:changedRating:)])
                    {
                        [_delegate ratingControl:self changedRating:_rating];
                        
                        
                    }
                }
                
                break;
            }
            
            currentsection.origin.x += _imageInterval + _imageSize.width;

		}
        
        
	}
	[self setNeedsDisplay];
}

@end


