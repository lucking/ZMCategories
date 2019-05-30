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

@interface ZMViewController ()

@end

@implementation ZMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [ZMCategorieTest test1];
    [UIView test1];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
