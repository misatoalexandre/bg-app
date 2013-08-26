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
    
	// Do any additional setup after loading the view.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"seeBookList"]) {
        BookListTVC *bltvc=(BookListTVC *)[segue destinationViewController];
        bltvc.managedObjectContext=self.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"addBook"]) {
        BookDetailTVC *bdtvc=(BookDetailTVC *)[segue destinationViewController];
        
        Book *newBook=(Book *)[NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
        bdtvc.currentBook=newBook;
        bdtvc.title=@"Add a Book";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
