//
//  PickerSwitchViewController.m
//  Assignment1
//
//  Created by Kevin Donahoo on 2/7/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "PickerSwitchViewController.h"

@interface PickerSwitchViewController () <UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pickerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;
@property (weak, nonatomic) IBOutlet UILabel *nemoLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *numberPicker;
@end

@implementation PickerSwitchViewController

- (IBAction)changeValueOfPickerLabel:(UIButton *)sender
{
    _pickerLabel.text = [NSString stringWithFormat:@"%d", [_numberPicker selectedRowInComponent:0]];
}


- (IBAction)changeFontSizeOfPickerLabel:(UISlider *)sender
{
    int num = sender.value;
    [_pickerLabel setFont:[UIFont systemFontOfSize:num]];
}

//switches text of label based on whether switch is on or off
- (IBAction)changeFindingNemoLabel:(UISwitch *)sender
{
    if (sender.on)
    {
        _nemoLabel.text = @"Nemo";
    }
    else
    {
        _nemoLabel.text = @"Finding";
    }
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
    
    //set up slider programmatically
    CGRect frame = CGRectMake(70.0, 150.0, 200.0, 10.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    slider.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [slider addTarget:self action:@selector(changeFontSizeOfPickerLabel:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 12.0;
    slider.maximumValue = 20.0;
    slider.continuous = YES;
    slider.value = 16.0;
    
    //set up picker
    _numberPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(-150, 200, 320, 200)];
    _numberPicker.delegate = self;
    _numberPicker.showsSelectionIndicator = YES;
    
    _numberPicker.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin  | UIViewAutoresizingFlexibleRightMargin;
    /*[_numberPicker.addContstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"V:"]]*/
    
    [self.view addSubview:slider];
    [self.view addSubview:_numberPicker];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//functions for picker
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 5;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d",row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

//code that handled orientation switching
/*- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"Change to custom UI for landscape");
        _switcher.frame = CGRectMake(self.view.frame.size.width/2 - _switcher.frame.size.width/2,self.view.frame.size.height/2 - _switcher.frame.size.height/2, _switcher.frame.size.width, _switcher.frame.size.height);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
             toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"Change to custom UI for portrait");
        
    }
}*/

@end
