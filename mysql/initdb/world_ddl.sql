DROP DATABASE IF EXISTS pl_world;
CREATE DATABASE pl_world
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

SET NAMES 'utf8mb4';

USE pl_world;

CREATE TABLE `Character` (
                             characterId bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
                             createTime datetime(6) DEFAULT NULL,
                             lastUpdateTime datetime(6) DEFAULT NULL,
                             accountId bigint(20) UNSIGNED NOT NULL,
                             characterState int(11) NOT NULL DEFAULT 1,
                             characterTribeId int(11) NOT NULL,
                             classType int(11) NOT NULL,
                             defenceModeStage int(11) NOT NULL DEFAULT 0,
                             deletionTime datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
                             enable bit(1) NOT NULL,
                             exp int(11) NOT NULL DEFAULT 0,
                             level int(11) NOT NULL DEFAULT 1,
                             nickname varchar(128) NOT NULL,
                             resurrectionTime datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
                             PRIMARY KEY (characterId)
)
ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE CraftRecipe (
                             accountId bigint(20) UNSIGNED NOT NULL,
                             recipeId int(11) NOT NULL,
                             createTime datetime(6) DEFAULT NULL,
                             lastUpdateTime datetime(6) DEFAULT NULL,
                             PRIMARY KEY (accountId, recipeId)
)
ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE AccountMaterial (
                                 accountId bigint(20) UNSIGNED NOT NULL,
                                 materialId int(11) NOT NULL,
                                 createTime datetime(6) DEFAULT NULL,
                                 lastUpdateTime datetime(6) DEFAULT NULL,
                                 amount int(11) NOT NULL DEFAULT 0,
                                 PRIMARY KEY (accountId, materialId)
)
    ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE AccountResource (
                                 accountId bigint(20) UNSIGNED NOT NULL,
                                 createTime datetime(6) DEFAULT NULL,
                                 lastUpdateTime datetime(6) DEFAULT NULL,
                                 actingPower int(10) UNSIGNED NOT NULL DEFAULT 0,
                                 actingPowerRestTime datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
                                 cashEvent int(11) NOT NULL DEFAULT 0,
                                 cashFree int(11) NOT NULL DEFAULT 0,
                                 cashPaid int(11) NOT NULL DEFAULT 0,
                                 dimensionAlchemy int(10) NOT NULL DEFAULT 0,
                                 gold int(11) NOT NULL DEFAULT 0,
                                 seq int(11) NOT NULL,
                                 socialPoint int(10) UNSIGNED NOT NULL DEFAULT 0,
                                 stone int(10) NOT NULL DEFAULT 0,
                                 wood int(10) NOT NULL DEFAULT 0,
                                 worldBossPowerFree int(10) NOT NULL DEFAULT 0,
                                 worldBossPowerPaid int(10) NOT NULL DEFAULT 0,
                                 PRIMARY KEY (accountId)
)
    ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE Item (
                      itemId bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
                      createTime datetime(6) DEFAULT NULL,
                      lastUpdateTime datetime(6) DEFAULT NULL,
                      accountId bigint(20) UNSIGNED NOT NULL,
                      amount int(11) NOT NULL DEFAULT 0,
                      equipPosition int(11) NOT NULL DEFAULT 0,
                      evolutionBroken tinyint(1) NOT NULL DEFAULT 0,
                      evolutionLevel int(11) NOT NULL DEFAULT 0,
                      exp int(11) NOT NULL DEFAULT 0,
                      inventoryType int(11) NOT NULL DEFAULT 0,
                      isNew tinyint(1) NOT NULL DEFAULT 1,
                      level int(11) NOT NULL DEFAULT 0,
                      locked tinyint(1) NOT NULL DEFAULT 0,
                      occupiedCharacterId bigint(20) UNSIGNED NOT NULL DEFAULT 0,
                      options varchar(512) DEFAULT NULL,
                      seq int(11) NOT NULL,
                      templateId int(11) NOT NULL DEFAULT 0,
                      transcend int(11) NOT NULL DEFAULT 0,
                      PRIMARY KEY (itemId),
                      INDEX idx_Item_accountId (accountId)
)
ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE Skill (
                       accountId bigint(20) UNSIGNED NOT NULL,
                       characterId bigint(20) UNSIGNED NOT NULL,
                       skillIndex int(11) UNSIGNED NOT NULL,
                       createTime datetime(6) DEFAULT NULL,
                       lastUpdateTime datetime(6) DEFAULT NULL,
                       level int(11) NOT NULL DEFAULT 0,
                       slotIndex int(11) NOT NULL DEFAULT -1,
                       slotType int(11) NOT NULL,
                       PRIMARY KEY (accountId, characterId, skillIndex)
)
    ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE SkillBook (
                           accountId bigint(20) UNSIGNED NOT NULL,
                           skillBookId int(11) NOT NULL,
                           createTime datetime(6) DEFAULT NULL,
                           lastUpdateTime datetime(6) DEFAULT NULL,
                           amount int(11) NOT NULL DEFAULT 0,
                           PRIMARY KEY (accountId, skillBookId)
)
    ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE WorldAccount (
                              accountId bigint(20) NOT NULL,
                              createTime datetime(6) DEFAULT NULL,
                              lastUpdateTime datetime(6) DEFAULT NULL,
                              attendanceDay int(11) UNSIGNED NOT NULL DEFAULT 0,
                              attendanceType int(11) UNSIGNED NOT NULL DEFAULT 0,
                              deleteFlag int(11) NOT NULL DEFAULT 0,
                              deleteTime datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
                              extendInventory int(11) UNSIGNED NOT NULL DEFAULT 0,
                              extendPetInven int(11) UNSIGNED NOT NULL DEFAULT 0,
                              loginTime datetime(6) NOT NULL,
                              logoutTime datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
                              nickname varchar(128) NOT NULL DEFAULT '',
                              lastWorldBossEventId int(11) NOT NULL DEFAULT 0,
                              worldBossPowerBuyCount int(11) NOT NULL DEFAULT 0,
                              PRIMARY KEY (accountId),
                              INDEX unique_WorldAccount_loginTime (loginTime)
)
    ENGINE = INNODB
CHARACTER SET utf32
COLLATE utf32_general_ci;

CREATE TABLE `AccountGuild` (
  `accountId` bigint NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `applyCount` int NOT NULL DEFAULT '0',
  `dailyApplyCount` int NOT NULL DEFAULT '0',
  `guildId` bigint NOT NULL DEFAULT '0',
  `joinCooltime` bigint NOT NULL,
  `lastApplyAt` bigint NOT NULL,
  `seq` int NOT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `AccountGuildApply` (
  `accountId` bigint unsigned NOT NULL,
  `guildId` bigint NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `dispositionType` int NOT NULL,
  `emblem` int NOT NULL,
  `guildName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `joinType` int NOT NULL,
  `leaderNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL,
  `members` int NOT NULL,
  `power` int NOT NULL,
  PRIMARY KEY (`accountId`,`guildId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Dungeon` (
    `autoKey` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `dungeonAddress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `dungeonId` bigint(20) NOT NULL,
    `dungeonIndex` int(11) NOT NULL,
    `dungeonName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `dungeonType` int(11) NOT NULL,
    `endTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
    `latitude` double NOT NULL,
    `longitude` double NOT NULL,
    `accountId` bigint(20) unsigned NOT NULL,
    `masterAccountName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `receiveReward` tinyint(1) NOT NULL,
    `s2CellId` bigint(20) unsigned NOT NULL,
    `startTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
    `clearTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
    `state` int(11) NOT NULL,
    `receiveRewardTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
    `useFreePass` tinyint(1) NOT NULL,
    PRIMARY KEY (`autoKey`),
    KEY `idx_accountId_dungeonId` (`accountId`,`dungeonId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Pet` (
  `petId` bigint NOT NULL AUTO_INCREMENT,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `accountId` bigint NOT NULL,
  `characterId` bigint NOT NULL DEFAULT '0',
  `characterSlot` int NOT NULL DEFAULT '0',
  `newTag` tinyint(1) NOT NULL DEFAULT '1',
  `petInfoId` int NOT NULL,
  `petStarRoad` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`petId`),
  KEY `idx_accountPet` (`accountId`,`petId`),
  KEY `idx_characterPet` (`accountId`,`characterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PetStar` (
  `accountId` bigint NOT NULL,
  `petStarId` int NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `amount` int NOT NULL DEFAULT '1',
  `newTag` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`accountId`,`petStarId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EquipCollect` (
  `accountId` bigint NOT NULL,
  `coltId` int NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`accountId`,`coltId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `EquipRecord` (
  `accountId` bigint NOT NULL,
  `templateId` int NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `record` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`accountId`,`templateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `WorldBoss` (
    `worldBossEventId` int(11) NOT NULL,
    `baseWorldBossEventId` int(11) NOT NULL,
    `growthCount` int(11) NOT NULL,
    `worldBossId` int(11) NOT NULL,
    PRIMARY KEY (`worldBossEventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `WorldBossUserRecord` (
    `worldAccountId` bigint(20) unsigned NOT NULL,
    `worldBossId` int(11) NOT NULL,
    `worldBossUserRecordId` bigint(20) NOT NULL,
    `attackCount` int(11) NOT NULL,
    `totalDamage` bigint(20) unsigned NOT NULL,
    `worldBossEventId` int(11) NOT NULL,
    PRIMARY KEY (`worldAccountId`,`worldBossId`,`worldBossUserRecordId`),
    UNIQUE KEY `idx_world_boss_user_record_id` (`worldBossUserRecordId`),
    UNIQUE KEY `idx_world_boss_user_record` (`worldAccountId`,`worldBossId`,`worldBossEventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
