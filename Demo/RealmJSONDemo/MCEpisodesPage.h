//
//  MCEpisodesPage.h
//  RealmJSONDemo
//
//  Created by Viktoras Laukevicius on 14/06/2019.
//  Copyright © 2019 Matthew Cheok. All rights reserved.
//

@import Realm;
#import "MCEpisode.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCEpisodesPage : RLMObject

@property (nonatomic) RLMArray<MCEpisode *><MCEpisode> *episodes;

@end

NS_ASSUME_NONNULL_END
