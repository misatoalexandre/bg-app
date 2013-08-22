//
//  GenreListTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGenreTVC.h"

@interface GenreListTVC : UITableViewController<NSFetchedResultsControllerDelegate, NewGenreTVCDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
