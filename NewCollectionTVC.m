//
//  NewCollectionTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "NewCollectionTVC.h"

@interface NewCollectionTVC ()

@end

@implementation NewCollectionTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionField.text=self.currentFavorite.favorite;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textResignFirstResponder:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)save:(id)sender {
    if (![self.collectionField.text isEqualToString:@""]) {
        [self.currentFavorite setFavorite:self.collectionField.text];
        [self.delegate newCollectionTVCSave];
        self.collectionField.text=@"";
    }else{
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Collection name missing" message:@"Please type a new collection name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
    }
}

- (IBAction)cancel:(id)sender {
    [self.delegate newCollectionTVCCancel:self.currentFavorite];
}
@end
