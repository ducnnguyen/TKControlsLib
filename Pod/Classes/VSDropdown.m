//
//  VSDropdown.m
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//

#import "VSDropdown.h"
#import <QuartzCore/QuartzCore.h>
#import "DropdownCell.h"

static const CGFloat kDefaultHeight = 264.f;
static const CGFloat kTableOffset = 0.0;
static const CGFloat kDropdownOffset = 0.0;

static const NSTimeInterval kDefaultDuration = 0.25;


@interface VSDropdown () {
    BOOL topEdgeRounded;
    CGRect viewFrame;
    CGFloat dropdownHeight;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSMutableArray *disabledArray;
@property (nonatomic,weak)   UIView *dropDownView;
@property (nonatomic,assign) VSDropdown_Direction assignedDirection;
@property (nonatomic, assign) CGFloat maxDropdownHeight;
@end

@implementation VSDropdown{
    UITableViewCell *_templateCell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
}


- (instancetype)initWithDelegate:(id<VSDropdownDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        [self setUpViews];
        [self didPerformSetup];
    }
    return self;
}

- (void)setUpViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.12]];
    [self addSubview:self.tableView];
    
}

- (void)setSeparatorColor:(UIColor *)sepratorColor {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:sepratorColor];
}

- (void)didPerformSetup {
    self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.12].CGColor;
    self.layer.borderWidth = 0.5f;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
}


- (void)setupDropdownForView:(UIView *)view {
    [self setupDropdownForView:view direction:VSDropdownDirection_Automatic];
    
}

- (void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction {
    [self setupDropdownForView:view direction:direction withTopColor:nil bottomColor:nil scale:0.2];
}


- (void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale {
    [self setupDropdownForView:view direction:direction withTopColor:baseColor bottomColor:nil scale:scale];
}


- (void)setupDropdownForView:(UIView *)view direction:(VSDropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale {
    [self remove];
    [self setDirection:direction];
    [self setDropDownView:view];
    [self performSetup];
    if ([self vs_prepareForAnimation]) {
        [self vs_performAnimation];
    } else {
        [self vs_finishPresentingDropdown];
    }

    [self setNeedsDisplay];
}


- (void)performSetup {
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    viewFrame = self.dropDownView.frame;
    UIView *superView = [self getParentViewForView:self.dropDownView];;
    [superView addSubview:self];
}

- (BOOL)vs_prepareForAnimation {
    BOOL animationRequired = YES;
    [self setAlpha:1];
    
    switch (self.drodownAnimation) {
        case DropdownAnimation_Fade:
            
            [self setAlpha:0];
            break;
            
        case DropdownAnimation_Scale:
            
            [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 0.1)];
            break;
        case DropdownAnimation_None:
            
            animationRequired = NO;
            break;
        default:
            break;
    }
    
    return animationRequired;
}


- (void)vs_performAnimation {
    [UIView animateWithDuration:[self animationDuration] animations:^{
        [self setAlpha:1];
        [self setTransform:CGAffineTransformIdentity];
        
    } completion:^(BOOL finished){
        if (finished) {
            [self vs_finishPresentingDropdown];
        }
    }];
    
}

- (void)vs_finishPresentingDropdown {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownDidAppear:)]) {
        [self.delegate dropdownDidAppear:self];
    }
}


- (NSTimeInterval)animationDuration {
    return kDefaultDuration;
    
}

-(UIView *)getParentViewForView:(UIView *)childView {
    UIView *parent = childView;
    while ([parent superview] && [[parent superview] isKindOfClass:[UIWindow class]] == NO)
    {
        parent = [parent superview];
    }
    return parent;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self assignDropdownDirectionAndFrame];
}

- (void)assignDropdownDirectionAndFrame {
    CGFloat height = self.maxDropdownHeight == 0 ? kDefaultHeight:self.maxDropdownHeight;
    if (self.tableView.contentSize.height <height + kTableOffset) {
        height = self.tableView.contentSize.height + kTableOffset;
    }
    dropdownHeight = height;
    
    if (self.direction == VSDropdownDirection_Down) {
        [self setAssignedDirection:VSDropdownDirection_Down];
        
    } else if (self.direction == VSDropdownDirection_Up) {
        [self setAssignedDirection:VSDropdownDirection_Up];
        
    } else {
        CGRect referenceFrame = [self.superview convertRect:viewFrame fromView:[self.dropDownView superview]];
        
        CGFloat totalHeight = referenceFrame.origin.y+referenceFrame.size.height+height;
        
        UIInterfaceOrientation appOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 == NO) {
            if (appOrientation == UIInterfaceOrientationLandscapeLeft || appOrientation == UIInterfaceOrientationLandscapeRight) {
                screenHeight = [UIScreen mainScreen].bounds.size.width;
            }
        }
        
        if (totalHeight < screenHeight) {
            [self setDirection:VSDropdownDirection_Automatic];
            [self setAssignedDirection:VSDropdownDirection_Down];
            
        } else {
            [self setDirection:VSDropdownDirection_Automatic];
            [self setAssignedDirection:VSDropdownDirection_Up];
        }
    }
    [self updateFrame];
    [self.tableView setFrame:self.bounds];
}

- (void)updateFrame {
    BOOL  topRounded = topEdgeRounded;
    CGRect frame = CGRectZero;
    
    viewFrame = self.dropDownView.frame;
    
    CGFloat dropdownOffset = kDropdownOffset;
    
    if (self.assignedDirection == VSDropdownDirection_Down) {
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y, viewFrame.size.width, dropdownHeight);
        topEdgeRounded = NO;
    } else {
        frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y+viewFrame.size.height-dropdownHeight-dropdownOffset, viewFrame.size.width, dropdownHeight);
        topEdgeRounded = YES;
    }
    
    frame = [self.superview convertRect:frame fromView:[self.dropDownView superview]];
    
    [self setFrame:frame];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didSetFrame:)])  {
        [self.delegate dropdown:self didSetFrame:frame];
    }
    
    if (topEdgeRounded != topRounded) {
        [self setNeedsDisplay];
    }
}


- (void)setAssignedDirection:(VSDropdown_Direction)assignedDirection
{
    _assignedDirection = assignedDirection;
    [self vs_configureAnchorPoint];
    
}

-(void)vs_configureAnchorPoint {
    if (self.drodownAnimation == DropdownAnimation_Scale) {
        if (self.assignedDirection == VSDropdownDirection_Down) {
            [self.layer setAnchorPoint:CGPointMake(0, 0)];
        } else if (self.assignedDirection == VSDropdownDirection_Up) {
            [self.layer setAnchorPoint:CGPointMake(1, 1)];
        }
    } else {
        [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    }
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (inside == NO && self.controlRemovalManually == NO) {
        [self remove];
    }
    return inside;
}

#pragma mark -
#pragma mark - UITableView Delegate/Data Source methods.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRowAtIndexPath = tableView.rowHeight;
    if ([self.delegate respondsToSelector:@selector(dropdown:heightForRowAtIndexPath:)]) {
        heightForRowAtIndexPath = [self.delegate dropdown:self heightForRowAtIndexPath:indexPath];
    }
    return heightForRowAtIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<DropdownCell> cell = [tableView dequeueReusableCellWithIdentifier:_templateCell.reuseIdentifier];
    NSAssert([cell respondsToSelector:@selector(bindCellData:)], @"The cells supplied to the DropDownCell must implement the DropdownCell protocol");
    [cell bindCellData:_dataArr[indexPath.row]];
    return (UITableViewCell *)cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id _item = [self.dataArr objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdown:didSelectItem:atIndex:)]) {
        [self.delegate dropdown:self didSelectItem:_item atIndex:[self.dataArr indexOfObject:_item]];
    }
    if (self.didSelectItem) {
        self.didSelectItem(_item, [self.dataArr indexOfObject:_item]);
    }
    [self remove];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(dropDown:viewForHeaderInSection:)]) {
        return [self.delegate dropDown:self viewForHeaderInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(dropDown:heightForHeaderInSection:)]) {
        return [self.delegate dropDown:self heightForHeaderInSection:section];
    }
    return 0.f;
}

- (void)reloadDropdownWithContents:(NSArray *)contents {
    [self reloadDropdownWithContents:contents selectedItem:nil];
}


- (void)reloadDropdownWithContents:(NSArray *)contents selectedItem:(id)selectedItem{
    UINib *templateCellNib = [self.delegate templateCellNibForDropdown:self];
    // create an instance of the template cell and register with the table view
    _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
    [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
    
    // use the template cell to set the row height
    _tableView.rowHeight = _templateCell.bounds.size.height;
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    if (self.dropDownView) {
        [self setDataArr:contents];
        [self.tableView reloadData];
        [self setNeedsLayout];
        [self setNeedsDisplay];
    } else {
        NSLog(@"It seems like the drodown has not been setup for any view yet. Please setup dropdown for view before reloading dropdown contents.");
    }
    
}

- (void)remove {
    [self.layer removeAllAnimations];
    UIView *superview = [self superview];
    if (superview) {
        if (self.dataArr && [self.dataArr count]>0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        [self removeFromSuperview];
    }
}

- (void)removeFromSuperview {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownWillDisappear:)])
    {
        [self.delegate dropdownWillDisappear:self];
    }
    
    [super removeFromSuperview];
    
}

- (void)cleanup {
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
}

- (void)dealloc {
    [self cleanup];
}

@end
