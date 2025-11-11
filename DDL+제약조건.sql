-- 🔥 외래키 검사 비활성화
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS comment_like;
DROP TABLE IF EXISTS post_comment;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS post_file;
DROP TABLE IF EXISTS post_tag;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS upload_file;
DROP TABLE IF EXISTS goal;
DROP TABLE IF EXISTS ban;
DROP TABLE IF EXISTS member_status;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS member_rank;
DROP TABLE IF EXISTS member_authority;
DROP TABLE IF EXISTS authorites;
DROP TABLE IF EXISTS login_failure_history;
DROP TABLE IF EXISTS refresh_token;
DROP TABLE IF EXISTS login_history;
DROP TABLE IF EXISTS extend_file_path;
DROP TABLE IF EXISTS meal_food;
DROP TABLE IF EXISTS food_fileupload;
DROP TABLE IF EXISTS ai_diet;
DROP TABLE IF EXISTS food;
DROP TABLE IF EXISTS meal;
DROP TABLE IF EXISTS `report_fileupload`;
DROP TABLE IF EXISTS `report`;
DROP TABLE IF EXISTS `report_base`;
DROP TABLE IF EXISTS `exercise_fileupload`;
DROP TABLE IF EXISTS `exercise`;
DROP TABLE IF EXISTS `black_list`;
DROP TABLE IF EXISTS `diary`;
DROP TABLE IF EXISTS `qna`;
DROP TABLE IF EXISTS `calendar`;
DROP TABLE IF EXISTS `diary_file`;
DROP TABLE IF EXISTS `qna_comment`;
DROP TABLE IF EXISTS `gacha_reward_grant`;
DROP TABLE IF EXISTS `gacha_draw_log`;
DROP TABLE IF EXISTS `gacha_shared_board`;
DROP TABLE IF EXISTS `gacha_board_seed`;
DROP TABLE IF EXISTS `gacha_quantity`;
DROP TABLE IF EXISTS `gacha_prize`;
DROP TABLE IF EXISTS `gacha_event`;
DROP TABLE IF EXISTS `gacha_reset`;

DROP TABLE IF EXISTS bingo_fileupload;
DROP TABLE IF EXISTS bingo_cell;
DROP TABLE IF EXISTS bingo_board;

DROP TABLE IF EXISTS point;

DROP TABLE IF EXISTS member_allergy;
DROP TABLE IF EXISTS allergy;
DROP TABLE IF EXISTS food_allergy;

DROP TABLE IF EXISTS base_of_point;


-- ------------- DDL -------------- --
CREATE TABLE IF NOT EXISTS upload_file (
                                           id   bigint   NOT NULL auto_increment,
                                           mime_type   VARCHAR(255)   not NULL,
    file_path   VARCHAR(255)   NOT NULL,
    created_at   DATETIME   NULL default now(),
    State   VARCHAR(255)   NULL,
    original_file_name   VARCHAR(255)   NULL,
    re_file_name   VARCHAR(255)   NULL,
    member_id   bigint   NOT NULL,
    extend_file_path_id   BIGINT   NOT NULL,
    constraint pk_upload_file_id primary key(id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS goal (
                                    id   bigint   NOT NULL auto_increment,
                                    type   ENUM('WEIGHT','CALORIE','MACRO') NOT NULL,
    target_value   DECIMAL(10,2)   NULL,
    kcal_per_day   INT   NULL,
    protein_g   INT   NULL,
    fat_g   INT   NULL,
    carbs_g   INT   NULL,
    start_date   DATETIME   NOT NULL,
    end_date   DATETIME   NULL,
    created_at   DATETIME   NOT NULL default now(),
    member_id   bigint   NOT NULL,
    constraint pk_goal_id primary key(id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ban (
                                   id   bigint   NOT NULL auto_increment,
                                   startDate   DATETIME   NOT NULL,
                                   endDate   DATETIME   NOT NULL,
                                   admin_id   bigint   NOT NULL,
                                   member_id   bigint   NOT NULL,
                                   report_no   bigint   NOT NULL,
                                   constraint pk_ban_id primary key(id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_status (
                                             id   bigint   NOT NULL auto_increment,
                                             status   varchar(255)   NULL,
    constraint pk_member_status_id primary key(id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member (
                                      id   bigint   NOT NULL auto_increment,
                                      name   VARCHAR(255)   NULL,
    nickname   VARCHAR(255)   NULL,
    email   VARCHAR(255)   NOT NULL,
    pw   VARCHAR(255)   NOT NULL,
    phone   VARCHAR(255)   NULL,
    gender   varchar(1)   NULL,
    birth   VARCHAR(255)   NULL,
    height   DECIMAL(5,2)   NOT NULL DEFAULT 0,
    weight   DECIMAL(5,2)   NOT NULL DEFAULT 0,
    body_metric   INT   NULL   COMMENT '회원 가입 할때 defualt로 계산 값 입력',
    point   INT   NULL,
    created_at   DATETIME   NOT NULL default now(),
    login_failure_count   int   NULL default 0,
    login_lock_until   datetime   NULL   COMMENT '연속5회 비밀번호 오류시 15분 접속 제한',
    quit_date   datetime   NULL,
    status   bigint   NOT NULL   DEFAULT 1,
    level   bigint   NOT NULL default 1,
    ban_cnt int null default 0,
    constraint pk_member_id primary key(id),
    constraint ck_member_gender check(gender in('M','F'))
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_rank (
                                           id   bigint   NOT NULL auto_increment,
                                           name   varchar(255)   NULL,
    badge_count   int   NULL   COMMENT '뱃지 갯수',
    constraint pk_member_rank_id primary key(id)
    ) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS member_authority (
                                                member_id   bigint   NOT NULL ,
                                                authories_id   bigint   NOT NULL,
                                                constraint pk_member_authority_member_id_authories_id primary key(member_id,authories_id)
    ) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS authorites (
                                          id   bigint   NOT NULL auto_increment,
                                          authurity   VARCHAR(255)   NOT NULL,
    description   varchar(255)   NULL,
    constraint pk_authorites_id primary key(id)
    ) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS login_failure_history (
                                                     id   bigint   NOT NULL auto_increment,
                                                     failure_datetime   datetime   NOT NULL,
                                                     failure_ip   varchar(255)   NULL,
    failure_reasone   varchar(2000)   NULL,
    member_id   bigint   NOT NULL,
    constraint pk_login_failure_history_id primary key(id)
    ) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS refresh_token (
                                             id   bigint   NOT NULL auto_increment,
                                             token_hash   varchar(128)   NOT NULL,
    jti   varchar(64)   NULL   COMMENT 'unique 제약조건',
    issued_at   datetime   NULL default now(),
    expires_at   datetime   NULL,
    revoked   tinyint   NULL   DEFAULT 0,
    revoked_at   datetime   NULL,
    device_fp   varchar(255)   NULL,
    ip   varchar(255)   NULL,
    last_used_at   datetime   NULL default now(),
    member_id   bigint   NOT NULL,
    constraint pk_refresh_token_id primary key(id),
    constraint uk_refresh_token_jti unique(jti)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS login_history (
                                             id   bigint   NOT NULL auto_increment,
                                             login_date   datetime   NOT NULL default now(),
    come_in_ip   varchar(255)   NULL,
    before_path   varchar(255)   NULL,
    member_id   bigint   NOT NULL,
    constraint pk_login_history_id primary key(id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS extend_file_path (
                                                id   BIGINT   NOT NULL auto_increment,
                                                url_path   VARCHAR(255) NULL,
    constraint pk_extend_file_path_id primary key(id)
    ) ENGINE=InnoDB;


-- 1) 태그
CREATE TABLE IF NOT EXISTS tag (
                                   id   INT   NOT NULL      AUTO_INCREMENT   ,
                                   name   VARCHAR(255)   NOT NULL   ,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;


-- 2) 게시판 (post)
CREATE TABLE IF NOT EXISTS post (
                                    id   INT   NOT NULL    AUTO_INCREMENT   ,
                                    title   VARCHAR(255)   NOT NULL,
    content   VARCHAR(255)   NULL,
    visibility   TINYINT(1)   NULL   DEFAULT 0   ,
    created_at   DATETIME   NOT NULL   DEFAULT CURRENT_TIMESTAMP ,
    member_id   bigint   NOT NULL,
    tag_id   INT   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

-- 3) 게시판 좋아요 (post_like)
CREATE TABLE IF NOT EXISTS post_like (
                                         id   bigint   NOT NULL    AUTO_INCREMENT   ,
                                         like_created   DATETIME   NOT NULL   DEFAULT CURRENT_TIMESTAMP ,
                                         member_id   bigint   NOT NULL,
                                         post_id   INT   NOT NULL,
                                         PRIMARY KEY (id)
    ) ENGINE=InnoDB;


-- 4) 게시판 댓글 (post_comment) + 대댓글 지원
CREATE TABLE IF NOT EXISTS post_comment (
                                            id   INT   NOT NULL    AUTO_INCREMENT   ,
                                            content   VARCHAR(255)   NOT NULL,
    create_at   DATETIME   NOT NULL   DEFAULT CURRENT_TIMESTAMP,
    post_id   INT   NOT NULL,
    member_id   BIGINT   NOT NULL,
    member_parent_comment_id   INT   NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;



-- 5) 댓글 좋아요 (comment_like)
CREATE TABLE IF NOT EXISTS comment_like (
                                            id   bigint   NOT NULL    AUTO_INCREMENT,
                                            create_at   DATETIME   NULL   DEFAULT CURRENT_TIMESTAMP ,
                                            member_id   bigint   NOT NULL,
                                            post_comment_id   INT   NOT NULL,
                                            PRIMARY KEY (id)
    ) ENGINE=InnoDB;

-- 6) 게시물 파일 업로드 (post_file)
CREATE TABLE IF NOT EXISTS post_file (
                                         id   INT   NOT NULL    AUTO_INCREMENT   ,
                                         name   VARCHAR(255)   NULL,
    url   VARCHAR(255)   NOT NULL,
    mime_type   VARCHAR(255)   NULL,
    path   VARCHAR(255)   NOT NULL,
    created_at   DATETIME   NULL   DEFAULT CURRENT_TIMESTAMP ,
    state   VARCHAR(255)   NULL,
    re_name   VARCHAR(255)   NULL,
    post_id   INT   NOT NULL,
    extend_file_path_id   INT   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS post_tag (
                                        id   INT   NOT NULL    AUTO_INCREMENT   ,
                                        name   VARCHAR(255)   NULL,
    post_id   INT   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS food (
                                    id   BIGINT   NOT NULL   AUTO_INCREMENT,
                                    name   VARCHAR(255)   NOT NULL,
    gram   INTEGER   NOT NULL,
    kcal   DECIMAL(8,2)   NOT NULL,
    carbo   DECIMAL(8,2)   NOT NULL,
    protein   DECIMAL(8,2)   NOT NULL,
    fat   DECIMAL(8,2)   NOT NULL,
    sodium   DECIMAL(10,2)   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS meal (
                                    id   BIGINT   NOT NULL   AUTO_INCREMENT ,
                                    type   ENUM('BREAKFAST','LUNCH','DINNER','SNACK')   NOT NULL,
    date   DATE   NOT NULL,
    created_at   DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    member_id   BIGINT   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS food_fileupload (
                                               id   INT   NOT NULL   AUTO_INCREMENT ,
                                               meal_id   BIGINT   NOT NULL   ,
                                               name   VARCHAR(255)   NOT NULL,
    type   VARCHAR(255)   NOT NULL,
    re_name   VARCHAR(255)   NOT NULL,
    path   VARCHAR(255)   NOT NULL,
    create_at   DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    upload_order   INT   NOT NULL,
    thumb_path   VARCHAR(255)   NOT NULL,
    extend_file_path_id   BIGINT   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS ai_diet (
                                       id   BIGINT   NOT NULL AUTO_INCREMENT   ,
                                       type   ENUM('BREAKFAST','LUNCH','DINNER','SNACK') NOT NULL,
    total_kcal   DECIMAL(8,2) NOT NULL,
    kcal   DECIMAL(8,2)   NOT NULL,
    total_protein   DECIMAL(8,2)   NOT NULL,
    total_fat   DECIMAL(8,2)   NOT NULL,
    created_at   DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name   VARCHAR(255)   NOT NULL,
    member_id   bigint   NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS meal_food (
                                         meal_id   BIGINT   NOT NULL,
                                         food_id   BIGINT   NOT NULL,
                                         PRIMARY KEY (meal_id, food_id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS report_base (
                                           id INT NOT NULL AUTO_INCREMENT,
                                           title VARCHAR(255) NOT NULL,
    count INT NOT NULL,
    day_of_ban INT DEFAULT 0,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS report (
                                      id BIGINT NOT NULL AUTO_INCREMENT,
                                      title VARCHAR(255) NOT NULL,
    contents VARCHAR(255) NOT NULL,
    yn BOOLEAN NOT NULL,
    date DATETIME NOT NULL,
    report_image_url VARCHAR(500),
    member_id2 BIGINT NOT NULL,
    post_id INT,
    comment_id INT,
    admin_id BIGINT,
    report_id INT NOT NULL,
    member_id BIGINT NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS report_fileupload (
                                                 id INT NOT NULL AUTO_INCREMENT,
                                                 report_id BIGINT NOT NULL,
                                                 name VARCHAR(255),
    type VARCHAR(255),
    re_name VARCHAR(255),
    path VARCHAR(255),
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    thumb_path VARCHAR(255),
    upload_order INT DEFAULT 1,
    extend_file_path_id BIGINT,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS exercise (
                                        id INT NOT NULL AUTO_INCREMENT,
                                        date DATE NOT NULL,
                                        type VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    min INT NOT NULL,
    burned_kcal INT NOT NULL,
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    member_id BIGINT NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS exercise_fileupload (
                                                   id INT NOT NULL AUTO_INCREMENT,
                                                   name VARCHAR(255),
    type VARCHAR(255),
    re_name VARCHAR(255),
    path VARCHAR(255),
    thumb_path VARCHAR(255),
    upload_order INT DEFAULT 1,
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    exercise_id INT NOT NULL,
    extend_file_path_id BIGINT,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS black_list (
                                          member_id BIGINT NOT NULL,
                                          create_date DATETIME NOT NULL,
                                          reason VARCHAR(2000) NOT NULL,
    admin_id BIGINT,
    PRIMARY KEY (member_id)
    ) ENGINE=INNODB;

/* DIARY 테이블 */

CREATE TABLE `diary` (
                         `id` INT NOT NULL AUTO_INCREMENT,
                         `day` DATETIME NOT NULL,
                         `weight` INT NOT NULL,
                         `mood` ENUM('아주좋음', '좋음', '보통', '나쁨', '아주나쁨'),
                         `condition` VARCHAR(255) NOT NULL,
                         `memo` VARCHAR(500) NOT NULL,
                         `member_id` BIGINT NOT NULL,
                         CONSTRAINT `pk_diary` PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='일기';


/* DIARY_FILE 테이블 */

CREATE TABLE `diary_file` (
                              `id` INT NOT NULL AUTO_INCREMENT,
                              `mime` VARCHAR(255) NOT NULL,
                              `path` VARCHAR(255) NOT NULL,
                              `created_at` DATETIME NOT NULL,
                              `state` VARCHAR(255) NOT NULL,
                              `original_file` VARCHAR(255) NOT NULL,
                              `rename` INT NOT NULL,
                              `diary_id` INT NOT NULL,
                              `extend_file_path_id` BIGINT NOT NULL,
                              CONSTRAINT `pk_diary_file` PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='일기 파일 업로드';


/* QNA 테이블 */

CREATE TABLE `qna` (
                       `id` BIGINT NOT NULL AUTO_INCREMENT,
                       `title` VARCHAR(255) NOT NULL,
                       `contents` VARCHAR(500) NOT NULL,
                       `created_at` DATETIME NOT NULL,
                       `member_id` BIGINT NOT NULL,
                       CONSTRAINT `pk_qna` PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='문의사항 게시글';


/* QNA_COMMENT 테이블 */

CREATE TABLE `qna_comment` (
                               `id` BIGINT NOT NULL AUTO_INCREMENT,
                               `comment` VARCHAR(500) NOT NULL,
                               `created_at` DATETIME NOT NULL,
                               `qna_id` BIGINT NOT NULL,
                               `member_id` BIGINT NOT NULL,
                               `parent_comment_id` BIGINT NULL,
                               CONSTRAINT `pk_qna_comment` PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='문의사항 댓글';


/* CALENDER 테이블 */

CREATE TABLE `calendar` (
                            `id` BIGINT NOT NULL AUTO_INCREMENT,
                            `cal_day` DATE NOT NULL,
                            `exercise_status` TINYINT NOT NULL DEFAULT 0,
                            `meal_status` TINYINT NOT NULL DEFAULT 0,
                            `diary_status` TINYINT NOT NULL DEFAULT 0,
                            `badge_yn` TINYINT(1) NOT NULL DEFAULT 0,
                            `member_id` BIGINT NOT NULL,
                            CONSTRAINT `pk_calendar` PRIMARY KEY (`id`),
                            CONSTRAINT `uq_calendar_member_day` UNIQUE (`member_id`, `cal_day`),
                            CONSTRAINT `chk_exercise_status` CHECK (`exercise_status` IN (0,1)),
                            CONSTRAINT `chk_meal_status` CHECK (`meal_status` IN (0,1)),
                            CONSTRAINT `chk_diary_status` CHECK (`diary_status` IN (0,1))
) ENGINE=InnoDB COMMENT='캘린더';

/* BINGO_BOARD */
CREATE TABLE `bingo_board` (
                               `id` INT NOT NULL AUTO_INCREMENT,
                               `title` VARCHAR(255) NOT NULL,
                               `size` INT NOT NULL,
                               `start_date` DATE NOT NULL,
                               `end_date` DATE NULL,
                               `created_at` DATETIME NOT NULL,
                               `member_id` BIGINT NOT NULL,
                               CONSTRAINT pk_bingo_board_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '';

/* BINGO_CELL */
CREATE TABLE `bingo_cell` (
                              `id` INT NOT NULL AUTO_INCREMENT,
                              `row` INT NOT NULL,
                              `col` INT NOT NULL,
                              `label` VARCHAR(255) NOT NULL,
                              `is_checked` TINYINT(1) NOT NULL,
                              `checked_at` DATETIME NULL,
                              `bingo_board_id` INT NOT NULL,
                              CONSTRAINT ck_bingo_cell_is_checked CHECK (`is_checked` IN (0,1)),
                              CONSTRAINT pk_bingo_cell_id PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/* BINGO_FILEUPLOAD */
CREATE TABLE `bingo_fileupload` (
                                    `id` INT NOT NULL AUTO_INCREMENT,
                                    `name` VARCHAR(500) NOT NULL,
                                    `mime_type` VARCHAR(500) NOT NULL,
                                    `re_name` VARCHAR(255) NULL,
                                    `path` VARCHAR(255) NOT NULL,
                                    `created_at` DATETIME NULL,
                                    `bingo_cell_id` INT NOT NULL,
                                    `extend_file_path_id` BIGINT NOT NULL,
                                    CONSTRAINT pk_bingo_fileupload_id PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* 2-1) 리셋 정책 (옵션) */
CREATE TABLE `gacha_reset` (
                               `id`          BIGINT       NOT NULL AUTO_INCREMENT,
                               `name`        VARCHAR(100) NOT NULL COMMENT '정책명',
                               `policy_type` ENUM('TOP_RANK','TIME','MANUAL','ETC') NOT NULL DEFAULT 'TOP_RANK' COMMENT '리셋 트리거 유형',
                               `policy_json` JSON         NULL COMMENT '세부 정책(JSON)',
                               `created_at`  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='가챠 리셋 정책';

/* 2-2) 이벤트 */
CREATE TABLE `gacha_event` (
                               `id`                    BIGINT   NOT NULL AUTO_INCREMENT,
                               `start_at`              DATETIME NOT NULL COMMENT '시작일시',
                               `end_at`                DATETIME NOT NULL COMMENT '종료일시',
                               `point`                 INT      NOT NULL DEFAULT 0 COMMENT '뽑기 1회 필요 포인트',
                               `status`                ENUM('DRAFT','ACTIVE','PAUSED','ENDED') NOT NULL DEFAULT 'DRAFT' COMMENT '상태',
                               `current_board_version` INT      NOT NULL DEFAULT 1 COMMENT '현재 운영중인 보드 버전',
                               `gacha_reset_id`        BIGINT   NOT NULL COMMENT '리셋 정책 ID',
                               `created_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='가챠 이벤트';

/* 2-3) 경품 */
CREATE TABLE `gacha_prize` (
                               `id`             BIGINT       NOT NULL AUTO_INCREMENT COMMENT '경품ID',
                               `name`           VARCHAR(100) NOT NULL COMMENT '경품명',
                               `payload_json`   JSON         NULL COMMENT '지급 페이로드(JSON)',
                               `prize_type`     ENUM('POINT','COUPON','ITEM','NOTHING','ETC') NOT NULL COMMENT '경품종류',
                               `rank`           INT          NOT NULL COMMENT '등급(작을수록 상위, 예: 1=최고)',
                               `gacha_event_id` BIGINT       NOT NULL COMMENT '소속 이벤트',
                               `created_at`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated_at`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='가챠 경품';

/* 2-4) 경품 전체 재고(선택: 1:1) */
CREATE TABLE `gacha_quantity` (
                                  `id`    BIGINT NOT NULL COMMENT 'gacha_prize.id 와 동일',
                                  `count` INT    NOT NULL DEFAULT 0 COMMENT '전체 재고(남은 수량)',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='경품 전체 재고(옵션)';

/* 2-5) 보드 시딩 분포(한 판에 몇 개씩 넣을지) */
CREATE TABLE `gacha_board_seed` (
                                    `id`              BIGINT NOT NULL AUTO_INCREMENT,
                                    `gacha_event_id`  BIGINT NOT NULL,
                                    `gacha_prize_id`  BIGINT NOT NULL,
                                    `count_per_board` INT    NOT NULL COMMENT '10x10=100칸 중 이 경품의 칸 수',
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='보드 시딩 분포 정의(합계는 반드시 100)';

/* 2-6) 공유 보드(핵심) - 10x10 셀, 버전별로 보관 */
CREATE TABLE `gacha_shared_board` (
                                      `id`                  BIGINT   NOT NULL AUTO_INCREMENT,
                                      `gacha_event_id`      BIGINT   NOT NULL COMMENT '이벤트 ID',
                                      `board_version`       INT      NOT NULL DEFAULT 1 COMMENT '보드 버전',
                                      `row`                 INT      NOT NULL COMMENT '행(1~10)',
                                      `col`                 INT      NOT NULL COMMENT '열(1~10)',
                                      `gacha_prize_id`      BIGINT   NOT NULL COMMENT '경품 ID',
                                      `status`              ENUM('COVERED','OPENED') NOT NULL DEFAULT 'COVERED' COMMENT '셀 상태',
                                      `opened_by_member_id` BIGINT   NULL COMMENT '오픈한 회원ID',
                                      `opened_at`           DATETIME NULL COMMENT '오픈 시각',
                                      `version`             INT      NOT NULL DEFAULT 0 COMMENT '낙관적 락 버전',
                                      `created_at`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                      `updated_at`          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공유 가챠 보드(10x10), 버전 운영';

/* 2-7) 뽑기 실행 로그 */
CREATE TABLE `gacha_draw_log` (
                                  `id`                    BIGINT   NOT NULL AUTO_INCREMENT COMMENT '로그ID',
                                  `created_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성시각',
                                  `updated_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정시각',
                                  `member_id`             BIGINT   NOT NULL COMMENT '회원ID',
                                  `gacha_event_id`        BIGINT   NOT NULL COMMENT '이벤트ID (그 당시)',
                                  `gacha_shared_board_id` BIGINT   NOT NULL COMMENT '해당 셀ID',
                                  `board_version`         INT      NOT NULL COMMENT '보드 버전(당시)',
                                  `prize_id`              BIGINT   NOT NULL COMMENT '당첨 경품ID',
                                  `prize_rank`            INT      NULL  COMMENT '당시 경품 랭크(선택)',
                                  `result_code`           ENUM('SUCCESS','ALREADY_OPENED','OUT_OF_STOCK','INVALID','ERROR')
                                                                   NOT NULL DEFAULT 'SUCCESS' COMMENT '결과 코드',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='뽑기 실행 로그';

/* 2-8) 지급 로그(큐) */
CREATE TABLE `gacha_reward_grant` (
                                      `id`                    BIGINT      NOT NULL AUTO_INCREMENT,
                                      `grant_status`          ENUM('QUEUED','GRANTED','FAILED') NOT NULL DEFAULT 'QUEUED' COMMENT '지급상태',
                                      `granted_at`            DATETIME    NULL COMMENT '지급시각',
                                      `created_at`            DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                      `gacha_shared_board_id` BIGINT      NOT NULL,
                                      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='경품 지급 처리 로그';

/* POINT (적립/사용 내역) */
CREATE TABLE `point` (
                         `point_id` BIGINT NOT NULL AUTO_INCREMENT,
                         `point` INT NULL,
                         `distinction` ENUM('EARN','USE') NULL COMMENT '1: 획득(EARN), 2: 사용(USE)',
                         `member_id` BIGINT NOT NULL,
                         `diary_id` INT  NULL,
                         `calender_id` BIGINT  NULL,
                         `gacha_event_id` BIGINT  NULL,
                         `bingo_board_id` INT  NULL,
                         histoy_time datetime not null default now(),
                         CONSTRAINT pk_point_point_id PRIMARY KEY (`point_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS member_allergy (
                                              id	INT	NOT NULL	AUTO_INCREMENT,
                                              member_id	BIGINT	NOT NULL,
                                              allergy_id	INT	NOT NULL,
                                              PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS allergy (
                                       id	INT	NOT NULL	AUTO_INCREMENT ,
                                       name	VARCHAR(255)	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS food_allergy (
                                            id	BIGINT	NOT NULL	AUTO_INCREMENT ,
                                            meal_id	BIGINT	NOT NULL,
                                            allergy_id	BIGINT	NOT NULL,
                                            PRIMARY KEY (id)
    ) ENGINE=INNODB;

    
create TABLE IF NOT EXISTS base_of_point(
	id int not null auto_increment,
	description varchar(2000),
	point int not null,
	constraint pk_base_of_point_id primary key(id)
)


-- ----- 제약조건 ----------
-- ✅ 외래키 검사 다시 활성화
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE post add CONSTRAINT fk_post_member FOREIGN KEY (member_id) REFERENCES member(id);
ALTER TABLE post add CONSTRAINT fk_post_tag FOREIGN KEY (tag_id) REFERENCES tag(id);

ALTER TABLE post_like add CONSTRAINT fk_postlike_post FOREIGN KEY (post_id) REFERENCES post(id);
ALTER TABLE post_like add CONSTRAINT fk_postlike_member FOREIGN KEY (member_id) REFERENCES member(id);
ALTER TABLE post_like add CONSTRAINT uq_post_like UNIQUE (post_id, member_id);

ALTER TABLE post_comment add CONSTRAINT fk_comment_post FOREIGN KEY (post_id) REFERENCES post(id);
ALTER TABLE post_comment add CONSTRAINT fk_comment_member FOREIGN KEY (member_id) REFERENCES member(id);
ALTER TABLE post_comment add CONSTRAINT fk_comment_parent FOREIGN KEY (member_parent_comment_id) REFERENCES post_comment(id);

ALTER TABLE comment_like add CONSTRAINT fk_cmtlike_comment FOREIGN KEY (post_comment_id) REFERENCES post_comment(id);
ALTER TABLE comment_like add CONSTRAINT fk_cmtlike_member FOREIGN KEY (member_id) REFERENCES member(id);
ALTER TABLE comment_like add CONSTRAINT uq_comment_like UNIQUE (post_comment_id, member_id);

ALTER TABLE post_file add CONSTRAINT fk_postfile_post FOREIGN KEY (post_id) REFERENCES post(id);

ALTER TABLE post_tag add CONSTRAINT fk_posttag_post FOREIGN KEY (post_id) REFERENCES post(id);

alter table upload_file add constraint fk_upload_file_member  foreign key(member_id)  references member(id);
alter table upload_file add constraint fk_upload_file_extend_file_path  foreign key(extend_file_path_id)  references extend_file_path(id);
alter table goal add constraint fk_goal_member   foreign key(member_id)  references member(id);
alter table ban add constraint fk_ban_member_member   foreign key(admin_id)  references member(id);
alter table ban add constraint fk_ban_member_admin   foreign key(member_id)  references member(id);
alter table ban add constraint fk_ban_report   foreign key(report_no)  references report(id);
alter table member add constraint fk_member_member_status   foreign key(status)  references member_status(id);
alter table member add constraint fk_member_member_rank   foreign key(level)  references member_rank(id);
alter table member_authority add constraint fk_member_authority_member   foreign key(member_id)  references member(id);
alter table member_authority add constraint fk_member_authority_authorites   foreign key(authories_id)  references authorites(id);
alter table login_failure_history add constraint fk_login_failure_history_member   foreign key(member_id)  references member(id) ;
alter table login_history add constraint fk_login_history_member   foreign key(member_id)  references member(id) ;
alter table refresh_token add constraint fk_refresh_token_member   foreign key(member_id)  references member(id);

ALTER TABLE meal_food ADD CONSTRAINT FK_meal_TO_meal_food_1 FOREIGN KEY (
                                                                         meal_id
    )
    REFERENCES meal (
                     id
        );

ALTER TABLE meal_food ADD CONSTRAINT FK_food_TO_meal_food_1 FOREIGN KEY (
                                                                         food_id
    )
    REFERENCES food (
                     id
        );

ALTER TABLE exercise_fileupload
    ADD CONSTRAINT fk_fileupload_exercise
        FOREIGN KEY (exercise_id) REFERENCES exercise(id)
            ON DELETE CASCADE;

ALTER TABLE report
    ADD CONSTRAINT fk_report_report_base
        FOREIGN KEY (report_id) REFERENCES report_base(id);

ALTER TABLE report_fileupload
    ADD CONSTRAINT fk_report_fileupload_report
        FOREIGN KEY (report_id) REFERENCES report(id)
            ON DELETE CASCADE;

ALTER TABLE black_list
    ADD CONSTRAINT fk_blacklist_admin
        FOREIGN KEY (admin_id) REFERENCES member(id);

ALTER TABLE diary_file add CONSTRAINT `fk_extend_file_path_to_diary_file_1` FOREIGN KEY (`extend_file_path_id`) REFERENCES `extend_file_path` (`id`);




ALTER TABLE qna_comment add CONSTRAINT `fk_qna_to_qna_comment_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`);

ALTER TABLE qna_comment add CONSTRAINT `fk_member_to_qna_comment_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

ALTER TABLE qna_comment add CONSTRAINT `fk_qna_comment_to_qna_comment_1` FOREIGN KEY (`parent_comment_id`) REFERENCES `qna_comment` (`id`);



ALTER TABLE calendar add CONSTRAINT `fk_member_to_calender_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);



ALTER TABLE qna add CONSTRAINT `fk_member_to_qna_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);



ALTER TABLE diary add CONSTRAINT `fk_member_to_diary_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

/* bingo_cell → bingo_board */
ALTER TABLE `bingo_cell`
    ADD CONSTRAINT `fk_bingo_cell_bingo_board`
        FOREIGN KEY (`bingo_board_id`) REFERENCES `bingo_board`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE;

/* bingo_board → member (이름도 의미있게 변경) */
ALTER TABLE `bingo_board`
    ADD CONSTRAINT `fk_bingo_board_member`
        FOREIGN KEY (`member_id`) REFERENCES `member`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

/* bingo_fileupload → bingo_cell (원래 보드가 아니라 ‘칸’을 참조해야 자연스러움) */
ALTER TABLE `bingo_fileupload`
    ADD CONSTRAINT `fk_bingo_fileupload_bingo_cell_id`
        FOREIGN KEY (`bingo_cell_id`) REFERENCES `bingo_cell`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE;

/* gacha_event */
ALTER TABLE `gacha_event`
    ADD CONSTRAINT `fk_gacha_event_reset`
        FOREIGN KEY (`gacha_reset_id`) REFERENCES `gacha_reset`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

/* gacha_prize */
ALTER TABLE `gacha_prize`
    ADD CONSTRAINT `fk_gacha_prize_event`
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE;

/* gacha_quantity */
ALTER TABLE `gacha_quantity`
    ADD CONSTRAINT `fk_gacha_quantity_prize`
        FOREIGN KEY (`id`) REFERENCES `gacha_prize`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE;

/* gacha_board_seed */
ALTER TABLE `gacha_board_seed`
    ADD CONSTRAINT `fk_seed_event`
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_seed_prize`
        FOREIGN KEY (`gacha_prize_id`) REFERENCES `gacha_prize`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD UNIQUE KEY `uk_seed_event_prize` (`gacha_event_id`,`gacha_prize_id`);

/* gacha_shared_board */
ALTER TABLE `gacha_shared_board`
    ADD CONSTRAINT `fk_shared_board_event`
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_shared_board_prize`
        FOREIGN KEY (`gacha_prize_id`) REFERENCES `gacha_prize`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_shared_board_member`
        FOREIGN KEY (`opened_by_member_id`) REFERENCES `member`(`id`)
            ON DELETE SET NULL ON UPDATE CASCADE,
    ADD UNIQUE KEY `uk_event_version_position` (`gacha_event_id`,`board_version`,`row`,`col`);

/* gacha_draw_log */
ALTER TABLE `gacha_draw_log`
    ADD CONSTRAINT `fk_drawlog_member`
        FOREIGN KEY (`member_id`) REFERENCES `member`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_drawlog_shared_board`
        FOREIGN KEY (`gacha_shared_board_id`) REFERENCES `gacha_shared_board`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_drawlog_event`
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT `fk_drawlog_prize`
        FOREIGN KEY (`prize_id`) REFERENCES `gacha_prize`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

/* gacha_reward_grant */
ALTER TABLE `gacha_reward_grant`
    ADD CONSTRAINT `fk_reward_shared_board`
        FOREIGN KEY (`gacha_shared_board_id`) REFERENCES `gacha_shared_board`(`id`)
            ON DELETE CASCADE ON UPDATE CASCADE;

/* point → member / diary / calender (각각 고유 이름) */
ALTER TABLE `point`
    ADD CONSTRAINT `fk_point_member_id`
        FOREIGN KEY (`member_id`) REFERENCES `member`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `point`
    ADD CONSTRAINT `fk_point_diary_id`
        FOREIGN KEY (`diary_id`) REFERENCES `diary`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `point`
    ADD CONSTRAINT `fk_point_calender_id`
        FOREIGN KEY (`calender_id`) REFERENCES `calendar`(`id`)
            ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE point
    ADD CONSTRAINT fk_point_gacha_event_id
        FOREIGN KEY (gacha_event_id) REFERENCES gacha_event(id);

ALTER TABLE point
    ADD CONSTRAINT fk_point_bingo_board_id
        FOREIGN KEY (bingo_board_id) REFERENCES bingo_board(id);