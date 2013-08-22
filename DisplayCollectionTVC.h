//
//  DisplayCollectionTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionListTVC.h"
#import "Favorite.h"


@interface DisplayCollectionTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *collectionField;
@property (strong, nonatomic) Favorite *selectedFavorite;
- (IBAction)save:(id)sender;
- (IBAction)edit:(id)sender;


@end
