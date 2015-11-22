
//
//  JCBUPostDetailedInfo.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedInfo.h"

@implementation JCBUPostDetailedInfo

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
                      usesig:(NSString *)usesig
{
  if (self = [super init]) {
    _aaid = aaid;
    _aid = aid;
    _attachment = attachment;
    _author = author;
    _authorid = authorid;
    _avatar = avatar;
    _bbcodeoff = bbcodeoff;
    _creditsrequire = creditsrequire;
    _dateline = dateline;
    _downloads = downloads;
    _epid = epid;
    _fid = fid;
    _filename = filename;
    _filesize = filesize;
    _filetype = filetype;
    _icon = icon;
    _lastedit = lastedit;
    _markpost = markpost;
    _message = message;
    _parseurloff = parseurloff;
    _pid = pid;
    _pstatus = pstatus;
    _rate = rate;
    _ratetimes = ratetimes;
    _score = score;
    _smileyoff = smileyoff;
    _subject = subject;
    _tid = tid;
    _uid = uid;
    _username = username;
    _usesig = usesig;
  }
  
  return self;
}

@end
