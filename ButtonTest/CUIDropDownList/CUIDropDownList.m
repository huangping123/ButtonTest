//
//  CUIDropDownList.m
//  ButtonTest
//
//  Created by jianglinjie on 13-11-13.
//  Copyright (c) 2013年 jianglingjie. All rights reserved.
//

#import "CUIDropDownList.h"
#import "CUICheckBox.h"


@interface CUIDropDownList()<UITableViewDataSource,UITableViewDelegate,CUICheckBoxDelegate>

@end


@implementation CUIDropDownList

@synthesize expanded = _expanded;

-(void) setDefaultValue
{
  
    _listHeight = 200;
    _expanded = NO;
    _selectedIndex = 0;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, _listHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alpha = 0.0;
    [self addSubview:_tableView];
    
    
    _button = [CUICheckBox buttonWithType:UIButtonTypeCustom];
    _button.frame = self.bounds;
    
    [_button setTitle:[[NSNumber numberWithInt:_selectedIndex] stringValue] forState:UIControlStateNormal];
    [_button setcheckedTitleColor:[UIColor redColor] uncheckedTitleColor:[UIColor blackColor]];
    [_button setcheckedImage:[UIImage imageNamed:@"UITableContract.png"] uncheckedImage:[UIImage imageNamed:@"UITableExpand.png"]];
    [_button addTarget:self action:@selector(dropDown:) forControlEvents:UIControlEventTouchUpInside];
    
    _button.delegate = self;
    [self addSubview:_button];
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValue];
        // Initialization code
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self setDefaultValue];

    }
    return self;
}

-(BOOL) isExpanded
{
    return _expanded;
}

-(void) setExpanded:(BOOL)expanded
{
    if(_expanded == expanded)
        return;
    
    if(expanded)
    {
        [self expandList];
    }
    else
    {
        [self closeList];
    
    }
}




-(void) expandList
{
    CGRect frame = self.frame;
    frame.size.height += _tableView.frame.size.height;
    self.frame = frame;
    
    //[self.superview bringSubviewToFront:self];
    
    _expanded = !_expanded;
    _tableView.alpha = 1.0;
    NSMutableArray* rowToInset = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_delegate numberOfElementsInDropDownList:self]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [rowToInset addObject:indexPath];
        
    }
    [_tableView insertRowsAtIndexPaths:rowToInset withRowAnimation:UITableViewRowAnimationFade];

}

-(void) closeList
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.size.height -= _tableView.frame.size.height;
        self.frame = frame;
        _tableView.alpha = 0.0;
        _expanded = !_expanded;
        NSMutableArray* rowToDelete = [[NSMutableArray alloc] init];
        for (int i = 0; i <  [_delegate numberOfElementsInDropDownList:self]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [rowToDelete addObject:indexPath];
            
        }
        [_tableView deleteRowsAtIndexPaths:rowToDelete withRowAnimation:UITableViewRowAnimationFade];
    }];




}

-(void) dropDown:(id)sender
{
    if(!_expanded)
    {
        [self expandList];
    
    }
    else
    {
        [self closeList];
    
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_expanded)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(numberOfElementsInDropDownList:)])
            return [_delegate numberOfElementsInDropDownList:self];
        return 0;
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:cellForElementAtIndex:isSelected:)])
    {
        
        return [_delegate dropDownList:self cellForElementAtIndex:indexPath.row isSelected:indexPath.row == _selectedIndex];
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
    
    self.selectedIndex = indexPath.row;
    
    [_button setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
    [_button setChecked:NO];

    [self closeList];
    

    
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownList:didSelectElementAtIndexPath:)])
    {
        [_delegate dropDownList:self didSelectElementAtIndexPath:_selectedIndex];
    }

}




-(void) reloadData
{
    [_tableView reloadData];
}

-(void) setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self reloadData];

}

-(void) setDelegate:(id<CUIDropDownListDelegate>)delegate
{
    if(_delegate != delegate)
    {
        _delegate = delegate;
        [self reloadData];
    }
}


@end
