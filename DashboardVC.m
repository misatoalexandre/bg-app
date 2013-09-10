//
//  DashboardVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/26/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "DashboardVC.h"
#import "BookListTVC.h"
#import "BookDetailTVC.h"

@interface DashboardVC ()

@end

@implementation DashboardVC

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
 

    self.totalBookCountLabel.layer.cornerRadius=40;
    self.readBookCountLabel.layer.cornerRadius=40;
    self.popularCategory.layer.cornerRadius=40;
   
    //Become observer of book count.
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(receiveNotification:)
                                                name:@"TotalBookCount"
                                              object:nil];
    
}
//receive book count's notification.
-(void)receiveNotification:(NSNotification *)notification{
    if ([[notification name]isEqualToString:@"TotalBookCount"]) {
        NSString *count =[notification.userInfo objectForKey:@"books"];
        NSString *bookCountDisplay=[NSString stringWithFormat:@"%@", count];
        self.totalBookCountLabel.text=bookCountDisplay;
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"seeBookList"]) {
        BookListTVC *bltvc=(BookListTVC *)[segue destinationViewController];
        bltvc.managedObjectContext=self.managedObjectContext;
        //bltvc.delegate=self;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
}



@end
