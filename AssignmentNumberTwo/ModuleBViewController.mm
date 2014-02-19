//
//  ModuleBViewController.m
//  AssignmentNumberTwo
//
//  Created by Amanda D on 2/19/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ModuleBViewController.h"
#import "Novocaine.h"
#import "AudioFileReader.h"
#import "RingBuffer.h"
#import "SMUGraphHelper.h"
#import "SMUFFTHelper.h"

#define kBufferLength 4096

@interface ModuleBViewController ()

@end

@implementation ModuleBViewController

Novocaine *audioManager2;
RingBuffer *ringBuffer2;
GraphHelper *graphHelper2;
float *audioData2;

SMUFFTHelper *fftHelper2;
float *fftMagnitudeBuffer2;
float *fftPhaseBuffer2;


//  override the GLKView draw function, from OpenGLES
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    graphHelper2->draw(); // draw the graph
}


//  override the GLKViewController update function, from OpenGLES
- (void)update{
    
    // plot
    ringBuffer2->FetchFreshData2(audioData2, kBufferLength, 0, 1);
    graphHelper2->setGraphData(0,audioData2,kBufferLength); // set graph channel
    
    fftHelper2->forward(0,audioData2, fftMagnitudeBuffer2, fftPhaseBuffer2);
    
    // plot
    graphHelper2->setGraphData(1,fftMagnitudeBuffer2,kBufferLength/2,sqrt(kBufferLength)); // set graph channel
    
    graphHelper2->update(); // update the graph
}

-(void) viewDidDisappear:(BOOL)animated{
    // stop opengl from running
    graphHelper2->tearDownGL();
}

-(void)dealloc{
    graphHelper2->tearDownGL();
    
    free(audioData2);
    
    free(fftMagnitudeBuffer2);
    free(fftPhaseBuffer2);
    delete fftHelper2;
    
    // ARC handles everything else, just clean up what we used c++ for (calloc, malloc, new)
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    audioManager2 = [Novocaine audioManager];
    ringBuffer2 = new RingBuffer(kBufferLength,2);
    
    audioData2 = (float*)calloc(kBufferLength,sizeof(float));
    
    //setup the fft
    fftHelper2 = new SMUFFTHelper(kBufferLength,kBufferLength,WindowTypeRect);
    fftMagnitudeBuffer2 = (float *)calloc(kBufferLength/2,sizeof(float));
    fftPhaseBuffer2     = (float *)calloc(kBufferLength/2,sizeof(float));
    
    // start animating the graph
    int framesPerSecond = 15;
    int numDataArraysToGraph = 2;
    graphHelper2 = new GraphHelper(self,
                                  framesPerSecond,
                                  numDataArraysToGraph,
                                  PlotStyleSeparated);
    
    graphHelper2->SetBounds(-0.5,0.5,-0.9,0.9); // bottom, top, left, right, full screen==(-1,1,-1,1)
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //NSURL *inputFileURL = [[NSBundle mainBundle] URLForResource:@"satisfaction" withExtension:@"mp3"];
    
    
    [audioManager2 setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         if (ringBuffer2!= nil) {
             ringBuffer2->AddNewFloatData(data, numFrames);
         }
     }];
    
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
