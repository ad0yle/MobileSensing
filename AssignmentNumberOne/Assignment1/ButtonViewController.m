//
//  ButtonViewController.m
//  Assignment1
//
//  Created by Kevin Donahoo on 2/6/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ButtonViewController

- (IBAction)changeBackgroundColorToBlue:(UIButton *)sender
{
    self.view.backgroundColor = [UIColor blueColor];
}

- (IBAction)changeBackgroundColorToRed:(UIButton *)sender
{
    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)changeOpacity:(UISlider *)sender
{
    float num = sender.value;
    _label.text = [NSString stringWithFormat:@"%f", num];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(changeBackgroundColorToRed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Red" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(self.view.frame.size.width/2 - button.frame.size.width/2, self.view.frame.size.height/2 - button.frame.size.height/2 + 5, button.frame.size.width, button.frame.size.height);
    /*button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;*/
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_blueButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(110.0, 100.0, 250.0, 30)];
    _label.text = [NSString stringWithFormat:@"%f", _opacitySlider.value];

    NSLayoutConstraint *myConstraint =[NSLayoutConstraint constraintWithItem:button
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0 
                                                                    constant:0];
    
    [self.view addConstraint:myConstraint];
    [self.view addSubview:button];
    [self.view addSubview:_label];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
