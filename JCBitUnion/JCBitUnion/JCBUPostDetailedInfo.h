//
//  JCBUPostDetailedInfo.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUPostDetailedInfo : NSObject

@property (nonatomic) NSString *aaid;
@property (nonatomic) NSString *aid;
@property (nonatomic) NSString *attachment;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *authorid;
@property (nonatomic) NSString *avatar;
@property (nonatomic) NSString *bbcodeoff;
@property (nonatomic) NSString *creditsrequire;
@property (nonatomic) NSString *dateline;
@property (nonatomic) NSString *downloads;
@property (nonatomic) NSString *epid;
@property (nonatomic) NSString *fid;
@property (nonatomic) NSString *filename;
@property (nonatomic) NSString *filesize;
@property (nonatomic) NSString *filetype;

@property (nonatomic) NSString *icon;
@property (nonatomic) NSString *lastedit;
@property (nonatomic) NSString *markpost;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *parseurloff;
@property (nonatomic) NSString *pid;
@property (nonatomic) NSString *pstatus;
@property (nonatomic) NSString *rate;
@property (nonatomic) NSString *ratetimes;
@property (nonatomic) NSString *score;
@property (nonatomic) NSString *smileyoff;

@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *tid;
@property (nonatomic) NSString *uid;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *usesig;

- (instancetype)initWithAaid:(NSString *)aaid
                         aid:(NSString *)aid
                  attachment:(NSString *)attachment
                      author:(NSString *)author
                    authorid:(NSString *)authorid
                      avatar:(NSString *)avatar
                   bbcodeoff:(NSString *)bbcodeoff
                  creditsrequire:(NSString *)creditsrequire
                    dateline:(NSString *)dateline
                   downloads:(NSString *)downloads
                        epid:(NSString *)epid
                         fid:(NSString *)fid
                    filename:(NSString *)filename
                    filesize:(NSString *)filesize
                    filetype:(NSString *)filetype
                        icon:(NSString *)icon
                    lastedit:(NSString *)lastedit
                    markpost:(NSString *)markpost
                     message:(NSString *)message
                 parseurloff:(NSString *)parseurloff
                         pid:(NSString *)pid
                     pstatus:(NSString *)pstatus
                        rate:(NSString *)rate
                   ratetimes:(NSString *)ratetimes
                       score:(NSString *)score
                   smileyoff:(NSString *)smileyoff
                     subject:(NSString *)subject
                         tid:(NSString *)tid
                         uid:(NSString *)uid
                    username:(NSString *)username
                      usesig:(NSString *)usesig;

@end
