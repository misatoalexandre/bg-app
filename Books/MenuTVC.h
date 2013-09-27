//
//  MenuTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 9/16/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTVC : UITableViewController
@property  (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *bookCountLabel;

//- (IBAction)infoButton:(id)sender;

@end

