//
//  Book.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "Book.h"
#import "Favorite.h"
#import "Genre.h"
#import "Status.h"


@implementation Book

@dynamic author;
@dynamic dateAdded;
@dynamic notes;
@dynamic title;
@dynamic favorite;
@dynamic genre;
@dynamic status;

-(void)awakeFromInsert{
    [super awakeFromInsert];
    self.dateAdded=[NSDate date];
    }


@end
