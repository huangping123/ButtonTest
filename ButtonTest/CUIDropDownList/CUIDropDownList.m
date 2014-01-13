//
//  CUIDropDownList.m
//  ButtonTest
//
//  Created by jianglinjie on 13-11-13.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "CUIDropDownList.h"
#import "CUIDropDowListCell.h"
#import "CUICheckBox.h"
#define DrowDownListHeight 50


@interface CUIDropDownList()<UITableViewDataSource,UITableViewDelegate,CUICheckBoxDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, assign) UIView *containerView;
@property (strong, nonatomic) UIView *drowDownListHead;
@property (strong, nonatomic) UIButton *coverButton;
@property (strong, nonatomic) NSTimer *autoDismissTimer;
@property (nonatomic, assign) CGRect dropDownListFrame;
@property (nonatomic, assign) CGRect tableViewBeginFrame;
@property (nonatomic, assign) CGRect tableViewEndFrame;
@property (nonatomic, assign) CGRect tableViewMiddleFrame;

@end


@implementation CUIDropDownList



-(void) setDefaultValue
{
  

    self.clipsToBounds = YES;
    //self.layer.borderWidth = 2;
    //self.layer.borderColor = [[UIColor blueColor] CGColor];
    
    
    _selectedIndex = 0;
    _preselectedIndex = 0;
    _needHeaderView = NO;
    _needmiddleAnimation = NO;
    _needBackCover = NO;
    _shouldAutoDismiss = NO;
    _shouldAnimation = YES;
    _state = Closed;
    
    _expandedInterval = 0.1;
    _closedInterval = 0.1;
    _middleInterval = 0.1;
    _autoDismissInterval = 2;
    _direction = PopDown;
    
    self.backgroundColor = [UIColor clearColor];
    
    
    _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverButton.backgroundColor = [UIColor blackColor];
    _coverButton.alpha = 0.5;
    [_coverButton addTarget:self action:@selector(onBackTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_coverButton];
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollsToTop = NO;
    _tableView.bounces = NO;
    //_tableView.layer.borderColor = [[UIColor redColor] CGColor];
    //_tableView.layer.borderWidth = 2;
    [self addSubview:_tableView];
    
    _drowDownListHead = [[UIView alloc] initWithFrame:CGRectZero];
    //_drowDownListHead.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0];
    _drowDownListHead.backgroundColor = [UIColor blackColor];
    _drowDownListHead.alpha = 0.9;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setDefaultValue];
    }
    return self;
}

-(id) initWithDelegate:(id<CUIDropDownListDelegate>)delegate
{
    if(self = [self initWithFrame:CGRectZero])
    {
        _delegate = delegate;
    
    }
    
    return self;
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}



-(void) setDisplayFrame
{
    
    
    if(_direction == PopDown && _needmiddleAnimation)
    {
        if(_needBackCover)
        {
            _dropDownListFrame = CGRectMake(0,[self popPointOfDropDownList].y,self.containerView.frame.size.width,self.containerView.frame.size.height-[self popPointOfDropDownList].y);
            _tableViewBeginFrame = CGRectMake([self popPointOfDropDownList].x, -[self heightOfDropDownList]-DrowDownListHeight, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _tableViewEndFrame = CGRectMake([self popPointOfDropDownList].x, -DrowDownListHeight, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _tableViewMiddleFrame = CGRectMake([self popPointOfDropDownList].x, 0, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _drowDownListHead.frame = CGRectMake(0, 0, [self widthOfDropDownList], DrowDownListHeight);
        }
        else
        {
            _dropDownListFrame = CGRectMake([self popPointOfDropDownList].x,[self popPointOfDropDownList].y,[self widthOfDropDownList],[self heightOfDropDownList] + DrowDownListHeight);
            _tableViewBeginFrame = CGRectMake([self popPointOfDropDownList].x, -[self heightOfDropDownList]-DrowDownListHeight, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _tableViewEndFrame = CGRectMake([self popPointOfDropDownList].x, -DrowDownListHeight, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _tableViewMiddleFrame = CGRectMake([self popPointOfDropDownList].x, 0, [self widthOfDropDownList], [self heightOfDropDownList]+DrowDownListHeight);
            _drowDownListHead.frame = CGRectMake(0, 0, [self widthOfDropDownList], DrowDownListHeight);
        }
        
        
    }
    else if(_direction == PopDown)
    {
        if(_needBackCover)
        {
            _dropDownListFrame = CGRectMake(0,[self popPointOfDropDownList].y,self.containerView.frame.size.width,self.containerView.frame.size.height-[self popPointOfDropDownList].y);
            _tableViewBeginFrame = CGRectMake([self popPointOfDropDownList].x, -[self heightOfDropDownList], [self widthOfDropDownList], [self heightOfDropDownList]);
            _tableViewEndFrame = CGRectMake([self popPointOfDropDownList].x, 0, [self widthOfDropDownList], [self heightOfDropDownList]);
        }
        else
        {
            _dropDownListFrame = CGRectMake([self popPointOfDropDownList].x,[self popPointOfDropDownList].y,[self widthOfDropDownList],[self heightOfDropDownList]);
            _tableViewBeginFrame = CGRectMake([self popPointOfDropDownList].x, -[self heightOfDropDownList], [self widthOfDropDownList], [self heightOfDropDownList]);
            _tableViewEndFrame = CGRectMake([self popPointOfDropDownList].x, 0, [self widthOfDropDownList], [self heightOfDropDownList]);
        }
        
       
    }
    else if(_direction == PopUp)
    {
        if(_needBackCover)
        {
            _dropDownListFrame = CGRectMake(0,0,self.containerView.frame.size.width,[self popPointOfDropDownList].y);
            _tableViewBeginFrame = CGRectMake([self popPointOfDropDownList].x, [self popPointOfDropDownList].y, [self widthOfDropDownList], [self heightOfDropDownList]);
            _tableViewEndFrame = CGRectMake([self popPointOfDropDownList].x, [self popPointOfDropDownList].y-[self heightOfDropDownList], [self widthOfDropDownList], [self heightOfDropDownList]);
        }
        else
        {
            _dropDownListFrame = CGRectMake([self popPointOfDropDownList].x, [self popPointOfDropDownList].y-[self heightOfDropDownList], [self widthOfDropDownList], [self heightOfDropDownList]);
            _tableViewBeginFrame = CGRectMake(0, [self heightOfDropDownList], [self widthOfDropDownList], [self heightOfDropDownList]);
            _tableViewEndFrame = CGRectMake(0, 0, [self widthOfDropDownList], [self heightOfDropDownList]);
        }
        
       
    }
}

-(void) enableBackTap
{
    self.userInteractionEnabled = YES;
    _coverButton.hidden = NO;
}

-(void) disableBackTap
{
    self.userInteractionEnabled = NO;
    _coverButton.hidden = YES;
}

-(void) setDisplayView:(UIView *)view
{
    self.containerView = view;
    [self setDisplayFrame];
    self.frame = _dropDownListFrame;
    self.tableView.frame = _tableViewBeginFrame;
    if(_needBackCover)
    {
        _coverButton.frame = self.bounds;
    }
    //_coverButton.layer.borderColor = [[UIColor yellowColor] CGColor];
    //_coverButton.layer.borderWidth = 2;
    [self.containerView addSubview:self];
    [self disableBackTap];
}

-(void) autoDismissTimerFired:(NSTimer *)timer
{
    [self closeListwithCompletionBlock:NULL];
}



-(void) expandListwithCompletionBlock:(void (^)())completion
{
    //保证队列中永远只有一个待执行的操作
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    if(_state == Expanded)
    {
        return;
    }
    else if(_state == Expanding || _state == Closing)
    {
        [self performSelector:@selector(expandListwithCompletionBlock:) withObject:[completion copy] afterDelay:0.1];
        return;
    }

    [self enableBackTap];
    [self.containerView bringSubviewToFront:self];
    
    if(_shouldAnimation)
    {
        [UIView animateWithDuration:_expandedInterval delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.tableView.frame = _tableViewEndFrame;
            _state = Expanding;
        } completion:^(BOOL finished){
            _state = Expanded;
            if(_shouldAutoDismiss)
            {
                _autoDismissTimer = [NSTimer scheduledTimerWithTimeInterval:_autoDismissInterval target:self selector:@selector(autoDismissTimerFired:) userInfo:nil repeats:NO];
            
            }
            if(completion != NULL)
            {
                completion();
            }
        }];
    }
    else
    {
        self.tableView.frame = _tableViewEndFrame;
        _state = Expanded;
        if(_shouldAutoDismiss)
        {
            _autoDismissTimer = [NSTimer scheduledTimerWithTimeInterval:_autoDismissInterval target:self selector:@selector(autoDismissTimerFired:) userInfo:nil repeats:NO];
            
        }
        if(completion != NULL)
        {
            completion();
        }
    }

}

-(void) closeListwithCompletionBlock:(void (^)())completion
{
    //保证队列中永远只有一个待执行的操作
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [_autoDismissTimer invalidate];
    if(_state == Closed)
    {
        return;
    }
    else if(_state == Expanding || _state == Closing)
    {
        [self performSelector:@selector(closeListwithCompletionBlock:) withObject:[completion copy] afterDelay:0.1];
        return;
    
    }

    if(_shouldAnimation)
    {
        if(_needmiddleAnimation)
    
        {
            [UIView animateWithDuration:_middleInterval delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.tableView.frame = _tableViewMiddleFrame;
                _state = Closing;
            } completion:^(BOOL finished){
        
                [UIView animateWithDuration:_closedInterval delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.tableView.frame = _tableViewBeginFrame;
                } completion:^(BOOL finished){
                    _state = Closed;
                    [self disableBackTap];
                    if(completion != NULL)
                    {
                        completion();
                    }
                }];
            }];
        }
        else
        {
            [UIView animateWithDuration:_closedInterval delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.tableView.frame = _tableViewBeginFrame;
                _state = Closing;
            } completion:^(BOOL finished){
                _state = Closed;
                [self disableBackTap];
                if(completion != NULL)
                {
                    completion();
                }
            }];
        }
    }
    else
    {
        self.tableView.frame = _tableViewBeginFrame;
        _state = Closed;
        [self disableBackTap];
        if(completion != NULL)
        {
            completion();
        }
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(_delegate && [_delegate respondsToSelector:@selector(numberOfElementsInDropDownList:)])
    {
        return [_delegate numberOfElementsInDropDownList:self];
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:cellForElementAtIndex:)])
    {
        return [_delegate dropDownList:self cellForElementAtIndex:indexPath.row];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:heightForElementAtIndex:)])
        return [_delegate dropDownList:self heightForElementAtIndex:indexPath.row];
    return 30.0;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(_selectedIndex != indexPath.row)
    {
        _preselectedIndex = _selectedIndex;
        _selectedIndex = indexPath.row;
    
    }
    if(_needBackCover)
    {
        [self closeListwithCompletionBlock:^{
            if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:didSelectElementAtIndexPath:)])
            {
                [_delegate dropDownList:self didSelectElementAtIndexPath:_selectedIndex];

            }
        }];
    }
    else
    {
        if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:didSelectElementAtIndexPath:)])
        {
            [_delegate dropDownList:self didSelectElementAtIndexPath:_selectedIndex];
            
        }
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self heightOfHeaderView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self HeaderView];

}


-(void) reloadData
{
    [_tableView reloadData];
    [self setDisplayFrame];
}


-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    if(selectedIndex >= [_delegate numberOfElementsInDropDownList:self])
    {
        return;
    }
    
    if(_selectedIndex != selectedIndex)
    {
        _preselectedIndex = _selectedIndex;
        _selectedIndex = selectedIndex;
    }
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

-(void) onBackTap:(id) sender
{
    if(_state == Expanded)
    {
        [self closeListwithCompletionBlock:^{
            NSLog(@"Closed Finished");
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    
    if(CGRectContainsPoint(_tableView.frame, point))
    {
        return NO;
    }
    
    return YES;
}

- (CGFloat)heightOfHeaderView
{
    if(!_needHeaderView)
    {
        return 0.0;
        
    }
    if(_delegate && [_delegate respondsToSelector:@selector(heightOfHeaderViewIndropDownList:)])
    {
        return [_delegate heightOfHeaderViewIndropDownList:self];
    
    }
    
    return DrowDownListHeight;
}

- (UIView*)HeaderView
{
 
    
    if(_delegate && [_delegate respondsToSelector:@selector(HeaderViewOfdropDownList:)])
    {
        return [_delegate HeaderViewOfdropDownList:self];
    
    }
    
    return _drowDownListHead;
}

- (CGFloat) heightForElementAtIndex:(NSUInteger)index
{
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:heightForElementAtIndex:)])
    {
        return [_delegate dropDownList:self heightForElementAtIndex:index];
    
    }
    
    return 30.0;

}

-(CGFloat)heightOfDropDownList
{
    if(_delegate && [_delegate respondsToSelector:@selector(heightOfDropDownList:)])
    {
        return [_delegate heightOfDropDownList:self];
    
    }
    
    return 200;
}

-(CGFloat)widthOfDropDownList
{
    if(_delegate && [_delegate respondsToSelector:@selector(widthOfDropDownList:)])
    {
        return  [_delegate widthOfDropDownList:self];
    
    }
    
    return 100;

}


-(CGPoint)popPointOfDropDownList
{
    if(_delegate && [_delegate respondsToSelector:@selector(popPointOfDropDownList:)])
    {
        return [_delegate popPointOfDropDownList:self];
    
    }
    
    return CGPointZero;
}



@end
