//
//  BookGenreTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/20/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Genre.h"
#import "BookGenreDetailTVC.h"

@protocol BookGenreTVCDelegate;


@interface  BookGenreTVC : UITableViewController <NSFetchedResultsControllerDelegate,BookGenreDetailTVCDelegate>

@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) id <BookGenreTVCDelegate> delegate;
@property (strong, nonatomic) Genre *selectedGenre;

- (IBAction)cancel:(id)sender;
@end

@protocol BookGenreTVCDelegate

-(void)genreWasSelectedOnBookGenreTVC:(BookGenreTVC *)controller;
-(void)bookGenreTVCCancel;
@end




