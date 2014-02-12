//
//  TimerViewController.m
//  Assignment1
//
//  Created by Kevin Donahoo on 2/6/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *animalLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) double timerValue;
@property NSTimer* timer;

@end

@implementation TimerViewController
@synthesize timerValue;
@synthesize timer;

- (IBAction)changedValue:(id)sender {
        timerValue =  [(UIStepper*)sender value];
    if (timerValue > 10) {
        timerValue = 10;
    }
    [timer invalidate];
    timer = nil;
     _timerLabel.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//when button is pressed, starts a timer based on value of stepper
- (IBAction)startTimer:(UIButton *)sender
{
    NSLog(@"%f",timerValue);
    timer = [NSTimer scheduledTimerWithTimeInterval:timerValue
                                                      target:self
                                                    selector:@selector(timeIsUp)
                                                    userInfo:Nil
                                                     repeats:NO];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timeIsUp
{
    if (timerValue == 0) {
    self.view.backgroundColor = [UIColor redColor];
    } else if (timerValue > 0 && timerValue <= 3) {
    self.view.backgroundColor = [UIColor greenColor];
    } else if (timerValue > 3 && timerValue <=6) {
    self.view.backgroundColor = [UIColor purpleColor];
    } else if (timerValue > 6) {
    self.view.backgroundColor = [UIColor orangeColor];
    }
    _timerLabel.text = @"Time is up!!";
    _timerLabel.hidden = NO;
    
}

//set up segmented control
- (IBAction)updateSegmentedControl:(UISegmentedControl *)sender
{
    NSString *selectedText = [sender titleForSegmentAtIndex: [sender selectedSegmentIndex]];
    
    _animalLabel.text = selectedText;
    
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
    timerValue = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
