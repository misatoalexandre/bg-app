//
//  BookDetailTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
@protocol BookDetailTVCDelegate;

@interface BookDetailTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (weak, nonatomic) IBOutlet UITextField *dateAddedField;

@property (strong, nonatomic) Book *currentBook;
@property (weak, nonatomic) id<BookDetailTVCDelegate> delegate;

- (IBAction)save:(id)sender;
@end

@protocol BookDetailTVCDelegate

-(void)bookDetailTVCDelegateSave:(BookDetailTVC *)controller;

@end
