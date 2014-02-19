//
//  ModuleAViewController.m
//  Assignment2
//
//  Created by Amanda D on 2/16/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ModuleAViewController.h"
#import "Novocaine.h"
#import "AudioFileReader.h"
#import "RingBuffer.h"
#import "SMUGraphHelper.h"
#import "SMUFFTHelper.h"

#define kBufferLength 4096

@interface ModuleAViewController ()

@end

@implementation ModuleAViewController

Novocaine *audioManager;
RingBuffer *ringBuffer;
GraphHelper *graphHelper;
float *audioData;

SMUFFTHelper *fftHelper;
float *fftMagnitudeBuffer;
float *fftPhaseBuffer;


//  override the GLKView draw function, from OpenGLES
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    graphHelper->draw(); // draw the graph
}


//  override the GLKViewController update function, from OpenGLES
- (void)update{
    
    // plot
    ringBuffer->FetchFreshData2(audioData, kBufferLength, 0, 1);
    graphHelper->setGraphData(0,audioData,kBufferLength); // set graph channel
    
    fftHelper->forward(0,audioData, fftMagnitudeBuffer, fftPhaseBuffer);
    
    // plot
    graphHelper->setGraphData(1,fftMagnitudeBuffer,kBufferLength/2,sqrt(kBufferLength)); // set graph channel
    
    graphHelper->update(); // update the graph
}

-(void) viewDidDisappear:(BOOL)animated{
    // stop opengl from running
    graphHelper->tearDownGL();
}

-(void)dealloc{
    graphHelper->tearDownGL();
    
    free(audioData);
    
    free(fftMagnitudeBuffer);
    free(fftPhaseBuffer);
    delete fftHelper;
    
    // ARC handles everything else, just clean up what we used c++ for (calloc, malloc, new)
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    audioManager = [Novocaine audioManager];
    ringBuffer = new RingBuffer(kBufferLength,2);
    
    audioData = (float*)calloc(kBufferLength,sizeof(float));
    
    //setup the fft
    fftHelper = new SMUFFTHelper(kBufferLength,kBufferLength,WindowTypeRect);
    fftMagnitudeBuffer = (float *)calloc(kBufferLength/2,sizeof(float));
    fftPhaseBuffer     = (float *)calloc(kBufferLength/2,sizeof(float));
    
    // start animating the graph
    int framesPerSecond = 15;
    int numDataArraysToGraph = 2;
    graphHelper = new GraphHelper(self,
                                  framesPerSecond,
                                  numDataArraysToGraph,
                                  PlotStyleSeparated);
    
    graphHelper->SetBounds(-0.5,0.5,-0.9,0.9); // bottom, top, left, right, full screen==(-1,1,-1,1)
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //NSURL *inputFileURL = [[NSBundle mainBundle] URLForResource:@"satisfaction" withExtension:@"mp3"];
    
    
    [audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         if (ringBuffer!= nil) {
         ringBuffer->AddNewFloatData(data, numFrames);
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
