//
//  Favorite.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favorite : NSManagedObject

@property (nonatomic, retain) NSString * favorite;
@property (nonatomic, retain) NSSet *favoriteBooks;
@end

@interface Favorite (CoreDataGeneratedAccessors)

- (void)addFavoriteBooksObject:(NSManagedObject *)value;
- (void)removeFavoriteBooksObject:(NSManagedObject *)value;
- (void)addFavoriteBooks:(NSSet *)values;
- (void)removeFavoriteBooks:(NSSet *)values;

@end
