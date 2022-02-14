DROP DATABASE IF EXISTS pl_global;
CREATE DATABASE pl_global
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

SET NAMES 'utf8mb4';

USE pl_global;

CREATE TABLE GlobalAccount (
    globalAccountId bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '계정 DB 아이디 (모든 DB에서 accountId로 사용)',
    shardToken int(11) NOT NULL COMMENT '계정 샤드 토큰 (AccountDB 샤드를 찾기 위한 토큰)',
    status int(11) NOT NULL DEFAULT 0 COMMENT '계정 상태 (0: 정상, 98:탈퇴대기, 99:탈퇴처리)',
    accountType tinyint(3) NOT NULL DEFAULT 0 COMMENT '계정타입(0:일반, 9:bot, 10:QA, 20:GM, 30:ADMIN)',
    osType tinyint(3) NOT NULL COMMENT '생성 시 device 운영체제',
    platformCode tinyint(3) NOT NULL COMMENT '생성 시 플랫폼코드',
    marketType tinyint(3) NOT NULL COMMENT '생성 시 마켓타입',
    countryCode varchar(10) NOT NULL COMMENT '생성 시 국가코드',
    langCode varchar(10) NOT NULL COMMENT '생성 시 언어코드',
    lastLoginTime datetime NOT NULL COMMENT '마지막 로그인 시간(UTC+0)',
    blockEndTime datetime DEFAULT NULL COMMENT '유저 접속 제재 종료 시간(UTC+0), 해당 없으면 NULL, PUSH/SMS 발송 filter용',
    withDrawTime datetime DEFAULT NULL COMMENT '탈퇴 요청/처리 시간(UTC+0)',
    kakaoConversionReward tinyint(3) NOT NULL DEFAULT 0 COMMENT '카카오 계정 전환 보상 여부( 0: 보상이력없음, 1 :보상완료) ',
    createTime datetime NOT NULL COMMENT '생성 시각 (UTC+0 기준)',
    lastUpdateTime datetime NOT NULL COMMENT '변경 시각 (UTC+0 기준)',
    PRIMARY KEY (globalAccountId)
)
ENGINE = INNODB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT = '글로벌 계정 정보';

CREATE TABLE AccountNickname (
    accountNickname varchar(128) NOT NULL COMMENT '계정 닉네임 (모든 월드에서 중복되지 않음)',
    worldAccountId bigint(20) UNSIGNED NOT NULL COMMENT '계정 DB 아이디',
    createTime datetime NOT NULL COMMENT '생성 시각 (UTC+0 기준)',
    lastUpdateTime datetime NOT NULL COMMENT '변경 시각 (UTC+0 기준)',
    PRIMARY KEY (accountNickname),
    INDEX idx_AccountNickname_accountId (worldAccountId)
)
    ENGINE = INNODB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT = '계정 닉네임';

-- CREATE TABLE AccountNicknameHistory (
--     id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '일련 번호, 자동발번',
--     accountId bigint(20) UNSIGNED DEFAULT 0 COMMENT '게임 계정 고유 아이디',
--     beforeNickname varchar(128) NOT NULL COMMENT '변경 전 닉네임',
--     afterNickname varchar(128) NOT NULL COMMENT '변경 후 닉네임',
--     createTime datetime NOT NULL COMMENT '생성 시각 (UTC+0 기준)',
--     lastUpdateTime datetime NOT NULL COMMENT '변경 시각 (UTC+0 기준)',
--     PRIMARY KEY (id),
--     INDEX idx_AccountNicknameHistory_beforeNickname (beforeNickname),
--     INDEX idx_account_nickname_history_afterNickname (afterNickname)
-- )
-- ENGINE = INNODB
-- CHARACTER SET utf8mb4
-- COLLATE utf8mb4_unicode_ci
-- COMMENT = '닉네임 변경 히스토리';

CREATE TABLE AccountPlatform (
    id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '게임내 플랫폼 계정 등록 고유 번호, 자동발번',
    platformCode tinyint(3) NOT NULL COMMENT '플랫폼 타입 코드',
    platformUid varchar(100) NOT NULL COMMENT '플랫폼 고유 아이디',
    globalAccountId bigint(20) UNSIGNED NOT NULL COMMENT '게임 계정 고유 아이디(account_global_info)',
    regStatus tinyint(3) NOT NULL DEFAULT 0 COMMENT '등록 타입, 0 : 최초 등록(게임계정생성), 1 : 추가 연동, 9 : 등록해제(게임계정삭제)',
    createTime datetime NOT NULL COMMENT '생성 시각 (UTC+0 기준)',
    lastUpdateTime datetime NOT NULL COMMENT '변경 시각 (UTC+0 기준)',
    PRIMARY KEY (id),
    INDEX idx_AccountPlatform_globalAccountId (globalAccountId),
    UNIQUE INDEX unique_AccountPlatform_platformCode_platformUid (platformCode, platformUid)
)
ENGINE = INNODB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT = '플랫폼 계정 정보';

CREATE TABLE `Guild` (
  `guildId` bigint NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `applicants` int NOT NULL DEFAULT '0',
  `dispositionType` int NOT NULL,
  `emblem` int NOT NULL DEFAULT '0',
  `exp` int NOT NULL DEFAULT '1',
  `guildName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `intro` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `joinType` int NOT NULL,
  `leaderAccountId` bigint unsigned NOT NULL,
  `leaderNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL DEFAULT '1',
  `members` int NOT NULL DEFAULT '1',
  `notice` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `power` bigint NOT NULL DEFAULT '0',
  `privateGuild` tinyint(1) NOT NULL DEFAULT '0',
  `recruitFactor` int NOT NULL DEFAULT '0',
  `seq` int NOT NULL,
  PRIMARY KEY (`guildId`),
  UNIQUE KEY `idx_guildName` (`guildName`),
  UNIQUE KEY `idx_leaderNick` (`leaderNick`),
  UNIQUE KEY `idx_leaderAccountId` (`leaderAccountId`),
  KEY `idx_recruit` (`guildId`,`joinType`,`privateGuild`,`recruitFactor`,`members`,`applicants`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `GuildApplicant` (
  `accountId` bigint unsigned NOT NULL,
  `guildId` bigint NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `accountNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `characterId` bigint NOT NULL,
  `characterTribeId` int NOT NULL,
  `classType` int NOT NULL,
  `level` int NOT NULL,
  `power` bigint NOT NULL,
  PRIMARY KEY (`accountId`,`guildId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `GuildMember` (
  `accountId` bigint NOT NULL,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `accountNick` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `characterId` bigint NOT NULL,
  `characterTribeId` int NOT NULL,
  `classType` int NOT NULL,
  `guildId` bigint NOT NULL,
  `lastActiveTime` bigint NOT NULL,
  `level` int NOT NULL,
  `memberType` bigint NOT NULL,
  `power` bigint NOT NULL,
  PRIMARY KEY (`accountId`),
  KEY `idx_guildId` (`guildId`),
  KEY `idx_guildMemberType` (`guildId`,`memberType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `GuildName` (
  `guildNameId` bigint NOT NULL AUTO_INCREMENT,
  `createTime` datetime(6) DEFAULT NULL,
  `lastUpdateTime` datetime(6) DEFAULT NULL,
  `guildName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shardToken` int NOT NULL,
  PRIMARY KEY (`guildNameId`),
  UNIQUE KEY `UK_guildName` (`guildName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `WorldBoss` (
    `worldBossEventId` int(11) NOT NULL,
    `baseWorldBossEventId` int(11) NOT NULL,
    `growthCount` int(11) NOT NULL,
    `worldBossId` int(11) NOT NULL,
    PRIMARY KEY (`worldBossEventId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
