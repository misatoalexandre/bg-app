//
//  DisplayCollectionTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "DisplayCollectionTVC.h"
#import "AppDelegate.h"

@interface DisplayCollectionTVC ()

@end

@implementation DisplayCollectionTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated   {
   self.saveBtn.hidden=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionField.text=self.selectedFavorite.favorite;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)save:(id)sender {
    self.saveBtn.hidden=YES;
    self.editBtn.hidden=NO;
    [self.collectionField setClearButtonMode:UITextFieldViewModeNever];
    
    [self.selectedFavorite setFavorite:self.collectionField.text];
    AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myApp saveContext];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Saved!" message:@"Collection name successfully updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)edit:(id)sender {
    self.saveBtn.hidden=NO;
    self.editBtn.hidden=YES;
    [self.collectionField setClearButtonMode:UITextFieldViewModeAlways];
    
    
}
@end
