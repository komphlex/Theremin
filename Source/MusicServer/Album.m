/*
 Copyright (C) 2006-2007  Patrik Weiskircher
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
 MA 02110-1301, USA.
 */

#import "Album.h"

NSString *gUnknownAlbumName = @"gUnknownAlbumName"; 

@implementation Album
- (id) init {
	self = [super init];
	if (self != nil) {
		mName = nil;
		mSQLIdentifier = -1;
	}
	return self;
}

- (void) dealloc {
	[mName release];
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"Album <0x%08x> Name: %@ SQLIdentifier: %d", self, [self name], [self SQLIdentifier]];
}

- (NSString *) name {
	return [[mName retain] autorelease];
}

- (int) SQLIdentifier {
	return mSQLIdentifier;
}

- (NSNumber *) CocoaSQLIdentifier {
	return [NSNumber numberWithInt:mSQLIdentifier];
}


- (void) setName:(NSString *)aName {
	[mName release];
	
	if ([aName isEqualToString:gUnknownAlbumName]) {
		mName = [TR_S_UNKNOWN_ALBUM retain];
	} else
		mName = [aName retain];
}

- (void) setSQLIdentifier:(int)aInteger {
	mSQLIdentifier = aInteger;
}


- (id)replacementObjectForPortCoder:(NSPortCoder *)encoder
{
    if ([encoder isBycopy]) return self;
    return [super replacementObjectForPortCoder:encoder];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:mName];
	[encoder encodeBytes:&mSQLIdentifier length:sizeof(mSQLIdentifier)];
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	mName = [[decoder decodeObject] retain];
	
	unsigned length;
	memcpy(&mSQLIdentifier, [decoder decodeBytesWithReturnedLength:&length], sizeof(mSQLIdentifier));
	
	return self;
}

@end