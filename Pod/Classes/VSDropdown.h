//
//  VSDropdown.h
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIKit.h>

/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, VSDropdown_Direction)
{
    /** Enum representing automatic direction.*/
    VSDropdownDirection_Automatic = 0,
    
    /** Enum representing up direction.*/
    VSDropdownDirection_Up,
    
    /** Enum representing down direction.*/
    VSDropdownDirection_Down
};

/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, DropdownAnimation)
{
    /** Enum representing automatic direction.*/
    DropdownAnimation_Fade = 0,
    
    /** Enum representing up direction.*/
    DropdownAnimation_Scale,
    
    /** Enum representing down direction.*/
    DropdownAnimation_None
};


@class VSDropdown;

@protocol VSDropdownDelegate <NSObject>

@required

- (UINib*)templateCellNibForDropdown:(VSDropdown *)dropDown;

@optional

- (CGFloat)dropdown:(VSDropdown *)dropDown heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)dropdown:(VSDropdown *)dropDown didSelectItem:(id)item atIndex:(NSUInteger)index;

- (void)dropdown:(VSDropdown *)dropDown didSetFrame:(CGRect )frame;

- (void)dropdownDidAppear:(VSDropdown *)dropDown;

- (void)dropdownWillDisappear:(VSDropdown *)dropDown;

- (UIView*)dropDown:(VSDropdown*)dropDown viewForHeaderInSection:(NSInteger)section;

- (CGFloat)dropDown:(VSDropdown*)dropDown heightForHeaderInSection:(NSInteger)section;
@end

@interface VSDropdown : UIView<UITableViewDataSource,UITableViewDelegate>

/** Holds reference to tableView used in dropdown. */
@property (nonatomic,readonly) UITableView *tableView;

/** Holds reference to view for which dropdown is called. */
@property(nonatomic,weak,readonly) UIView *dropDownView;

/** Array containing items to show in dropdown. */
@property(nonatomic,readonly) NSArray *dataArr;


/** Direction for dropdown*/
@property(nonatomic,assign) VSDropdown_Direction direction;

/** Assigned direction  for dropdown*/
@property(nonatomic,readonly)VSDropdown_Direction assignedDirection;


/** Determines whether dropdown should display items in sorted form. */
@property(nonatomic,assign) BOOL controlRemovalManually;


/** Delegate to recive events from dropdown */
@property(nonatomic,weak) id<VSDropdownDelegate>delegate;

/** Dropdown backGround imageview.*/
@property(nonatomic,assign) DropdownAnimation drodownAnimation;

- (instancetype)initWithDelegate:(id<VSDropdownDelegate>)delegate;

@property (nonatomic, copy) void(^didSelectItem)(id item, NSUInteger index);


/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 */
-(void)setupDropdownForView:(UIView *)view;

/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 */

- (void)remove;

- (void)reloadDropdownWithContents:(NSArray *)contents selectedItem:(id)selectedItem;

@end

