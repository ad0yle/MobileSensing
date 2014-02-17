//
//  PageDataSourceViewController.m
//  Assignment1
//
//  Created by Kevin Donahoo on 2/7/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "PageDataSourceViewController.h"
#import "ImageViewController.h"

@interface PageDataSourceViewController () <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController * pageViewController;
@property (strong, nonatomic) NSArray *pageContent;

@end

@implementation PageDataSourceViewController

// GETTERS
-(UIPageViewController*) pageViewController{
    if(!_pageViewController)
    {
        _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
        _pageViewController.dataSource = self;
        
    }
    
    return _pageViewController;
}

-(NSArray*)pageContent{
    if(!_pageContent)
        _pageContent = @[@"nemo",@"dory",@"squirt"];
    
    return _pageContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIViewController *firstViewController = (UIViewController*)[self createViewControllerFromIndex:0];
    
    NSArray *viewControllers = @[firstViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    // set the frame size
    self.pageViewController.view.frame = CGRectMake(0, 65, // leave room for the navigation controller
                                                    self.view.frame.size.width,
                                                    self.view.frame.size.height-95); // leave room for page control
    
    //the three lines below must be in this order
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(UIViewController*)createViewControllerFromIndex:(NSUInteger)index{
    if(index >= [self.pageContent count])
        return nil;
    
    ImageViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    
    //Set the images
    VC.imageName = self.pageContent[index];
    VC.pageIndex = index;
    
    return VC;
    
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    // get index from the current view controller
    NSUInteger index = ((ImageViewController*) viewController).pageIndex;
    
    // tell controller nothing if we are at begginning
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    // decrement our page index
    index--;
    return [self createViewControllerFromIndex:index];
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    // get index from the current view controller
    NSUInteger index = ((ImageViewController*) viewController).pageIndex;
    
    // tell controller nothing if we are at beginning
    if (index == NSNotFound) {
        return nil;
    }
    
    // increment our page index
    index++;
    
    // tell controller nothing if we are at end
    if (index == [self.pageContent count]) {
        return nil;
    }
    
    return [self createViewControllerFromIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageContent count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
