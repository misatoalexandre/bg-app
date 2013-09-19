//
//  BookCollectionDetailTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 9/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookCollectionDetailTVC.h"

@interface BookCollectionDetailTVC ()

@end

@implementation BookCollectionDetailTVC

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

- (IBAction)removeKeyboard:(id)sender {
    [self resignFirstResponder];
}


- (IBAction)save:(id)sender {
    if (![self.collectionField.text isEqualToString:@""]) {
        [self.currentFavorite setFavorite:self.collectionField.text];
        [self.delegate bookCollectionDetailTVCDelegateSave];
        self.collectionField.text=@"";
    }else{
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Collection name missing" message:@"Please type a new collection name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
    }
   }

- (IBAction)cancel:(id)sender {
    [self.delegate bookCollectionDetailTVCDelegateCancel:self.currentFavorite];
}




@end
