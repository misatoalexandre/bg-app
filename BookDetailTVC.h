//
//  BookDetailTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookGenreTVC.h"
#import "Genre.h"
#import "BookCollectionTVC.h"
#import "Favorite.h"
#import "BookStatusTVC.h"
#import "Status.h"


@protocol BookDetailTVCDelegate;

@interface BookDetailTVC : UITableViewController <BookGenreTVCDelegate,BookCollectionTVCDelegate, BookStatusTVCDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (weak, nonatomic) IBOutlet UITextField *dateAddedField;

@property (strong, nonatomic) Book *currentBook;
@property (strong, nonatomic) Genre *selectedGenre;
@property (strong, nonatomic) Favorite *selectedCollection;
@property (strong, nonatomic) Status *selectedStatus;
@property (weak, nonatomic) id<BookDetailTVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableViewCell *genreTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *CollectionTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *readingStatusTableView;

- (IBAction)save:(id)sender;
@end

@protocol BookDetailTVCDelegate

-(void)bookDetailTVCDelegateSave:(BookDetailTVC *)controller;

@end
