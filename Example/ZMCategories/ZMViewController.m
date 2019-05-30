//
//  ZMViewController.m
//  ZMCategories
//
//  Created by lucking on 05/30/2019.
//  Copyright (c) 2019 lucking. All rights reserved.
//

#import "ZMViewController.h"
#import <ZMCategorieLib/ZMCategorieTest.h>
#import <ZMCategorieLib/UIView+Test.h>
#import <ZMCategorieLib/NSDate+ZMAdd.h>
#import <ZMCategorieLib/ZMPerson.h>

@interface ZMViewController ()

@end

@implementation ZMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [ZMCategorieTest test1];
    [UIView test1];
    
    [ZMPerson test1];
    NSLog(@"---currentDate= %@",[NSDate getCurrentDateString]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
