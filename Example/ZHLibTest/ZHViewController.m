//
//  ZHViewController.m
//  ZHLibTest
//
//  Created by 398090509@qq.com on 11/21/2018.
//  Copyright (c) 2018 398090509@qq.com. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHAddressBook.h"

@interface ZHViewController ()

@end

@implementation ZHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

}


- (IBAction)buttonClick:(id)sender {
    ZHAddressBook *book = [[ZHAddressBook alloc]init];
    book.viewController = self;
    __weak typeof(book)weak_book = book;
    [book AddressBook:^(NSString *callback) {
        weak_book.viewController = nil;
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
