//
//  MultiplayerValues.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#ifndef DS_MultiplayerValues_h
#define DS_MultiplayerValues_h

// enumeration containing multiplayer states
typedef enum {
    kArenaStateWaitingForMatch = 0,
    kArenaStateWaitingForRandomNumber,
    kArenaStateWaitingForConfirmation,
    kArenaStateWaitingForOpponentStatus,
    kArenaStateWaitingForStart,
    kArenaStateActive,
    kArenaStateDone
} ArenaState;

// enumeration containing reasons multiplayer ends
typedef enum {
    kArenaEndReasonWin,
    kArenaEndReasonLose,
    kArenaEndReasonDisconnect
} ArenaEndReason;

// enumeration containing message types
typedef enum {
    kMessageTypeRandomNumber = 0,
    kMessageTypeConfirmation,
    kMessageTypePlayerStatus,
    kMessageTypeGameBegin,
    kMessageTypeDamage,
    kMessageTypeHeal,
    kMessageTypeGold,
    kMessageTypeShield,
    kMessageTypePotion,
    kMessageTypeBomb,
    kMessageTypeAle,
    kMessageTypeRune,
    kMessageTypeMirror,
    kMessageTypeFlute,
    kMessageTypeGameExit,
    kMessageTypeGameOver
} MessageType;

typedef struct {
    MessageType messageType;
} Message;

typedef struct {
    Message message;
    uint32_t randomNumber;
} MessageRandomNumber;

typedef struct {
    Message message;
    uint32_t isPlayer1;
} MessageConfirmation;

typedef struct {
    Message message;
    uint32_t level;
    uint32_t maxHP;
    uint32_t classVal;
    uint32_t attack;
    uint32_t defence;
    uint32_t magic;
    uint32_t luck;
    uint32_t shield;
    uint32_t damage_reduction;
} MessagePlayerStatus;

typedef struct {
    Message message;
    uint32_t confirmation;
} MessageGameBegin;

typedef struct {
    Message message;
    uint32_t damage;
} MessageDamage;

typedef struct {
    Message message;
    uint32_t heal;
} MessageHeal;

typedef struct {
    Message message;
} MessageGold;

typedef struct {
    Message message;
    uint32_t shieldRank;
} MessageShield;

typedef struct {
    Message message;
    uint32_t heal;
} MessagePotion;

typedef struct {
    Message message;
    uint32_t damage;
} MessageBomb;

typedef struct {
    Message message;
} MessageAle;

typedef struct {
    Message message;
} MessageRune;

typedef struct {
    Message message;
    uint32_t mirrorRank;
} MessageMirror;

typedef struct {
    Message message;
} MessageFlute;

typedef struct {
    Message message;
} MessageGameExit;

typedef struct {
    Message message;
} MessageGameOver;

#endif
