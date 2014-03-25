//
//  ViewController.m
//  CutCalculator
//
//  Created by Rajesh on 17/03/14.
//  Copyright (c) 2014 Innerglow IT Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//@synthesize calcPage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Home";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(calculate)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Calculate" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    [self calculate];
    if (IsIpad) {
        NSLog(@"hi Ipad");
    }
    else{
        if (IsIphone5) {
            NSLog(@"hi iphone5");
        }
        else
        {
            NSLog(@"hi iphone4");
        }
        
    }
    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)calculate{
    //calcPage=[[CalculationViewController alloc]init];
    //[self.navigationController pushViewController:calcPage animated:YES];
}

- (id)init
{
    if (self)
    {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            self = [super initWithNibName:nibName bundle:nil];
        }
        else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            self = [super initWithNibName:[nibName stringByAppendingString:@"Pad"] bundle:nil];
        }
        return self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
