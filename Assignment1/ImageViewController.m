//
//  ImageViewController.m
//  Assignment1
//
//  Created by Kevin Donahoo on 2/7/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;

@end

@implementation ImageViewController

// GETTERS by lazy instantiation
-(UIImage *)image{
    if(!_image) _image = [UIImage imageNamed:self.imageName];
    return _image;
}

-(UIImageView *)imageView{
    if(!_imageView) self.imageView = [[UIImageView alloc] initWithImage:self.image];
    return _imageView;
}

-(NSString *) imageName
{
    if(!_imageName) _imageName = @"nemo"; //SET DEFAULT IMAGE
    return _imageName;
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
    
    [self.imageScrollView addSubview:self.imageView];
    self.imageScrollView.contentSize = self.image.size;
    self.imageScrollView.minimumZoomScale = 0.1;
    self.imageScrollView.delegate = self;
    
    self.title  = self.imageName;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
