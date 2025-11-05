-- ----------------------------
-- 테이블 삭제 (참조 역순)
-- ----------------------------

-- 1. 자식 테이블 (Foreign Key를 가진 테이블) 먼저 제거
DROP TABLE IF EXISTS meal_food;
DROP TABLE IF EXISTS member_authority;
DROP TABLE IF EXISTS black_list;

-- 2. 부모 테이블 및 독립 테이블 제거
-- (참고: member, meal, food, authorites는 다른 테이블이 참조하므로 나중에 제거)
DROP TABLE IF EXISTS exercise;
DROP TABLE IF EXISTS bingo_board;
DROP TABLE IF EXISTS upload_file;
DROP TABLE IF EXISTS gacha_fileupload;
DROP TABLE IF EXISTS post_comment;
DROP TABLE IF EXISTS member_rank;
DROP TABLE IF EXISTS post_tag;
DROP TABLE IF EXISTS goal;
DROP TABLE IF EXISTS gacha_prize;
DROP TABLE IF EXISTS diary;
DROP TABLE IF EXISTS member_allergy;
DROP TABLE IF EXISTS qna;
DROP TABLE IF EXISTS refresh_token;
DROP TABLE IF EXISTS login_history;
DROP TABLE IF EXISTS bingo_cell;
DROP TABLE IF EXISTS calender;
DROP TABLE IF EXISTS exercise_fileupload;
DROP TABLE IF EXISTS gacha_board_cell;
DROP TABLE IF EXISTS gacha_event;
DROP TABLE IF EXISTS food_fileupload;
DROP TABLE IF EXISTS point;
DROP TABLE IF EXISTS login_failure_history;
DROP TABLE IF EXISTS report;
DROP TABLE IF EXISTS post_file;
DROP TABLE IF EXISTS diary_file;
DROP TABLE IF EXISTS allergy;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS report_base;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS ai_diet;
DROP TABLE IF EXISTS gacha_reward_grant;
DROP TABLE IF EXISTS bingo_fileupload;
DROP TABLE IF EXISTS member_status;
DROP TABLE IF EXISTS report_fileupload;
DROP TABLE IF EXISTS comment_like;
DROP TABLE IF EXISTS qna_comment;
DROP TABLE IF EXISTS ban;
DROP TABLE IF EXISTS food_allergy;
DROP TABLE IF EXISTS extend_file_path;
DROP TABLE IF EXISTS gacha_reset;
DROP TABLE IF EXISTS gacha_quantity;

-- 3. 최상위 부모 테이블 (다른 테이블이 참조하는 테이블) 제거
DROP TABLE IF EXISTS food;
DROP TABLE IF EXISTS meal;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS authorites;


DROP TABLE IF EXISTS `diary`;
DROP TABLE IF EXISTS `diary_file`;
DROP TABLE IF EXISTS `qna`;
DROP TABLE IF EXISTS `qna_comment`;
DROP TABLE IF EXISTS `calender`;

DROP TABLE IF EXISTS `report_base`;
DROP TABLE IF EXISTS `exercise`;

-- ----------------------------
-- 테이블 생성 (참조 순서)
-- ----------------------------

-- 1. 부모 테이블 (다른 테이블이 참조하는 테이블)
CREATE TABLE IF NOT EXISTS food (
                                    id	BIGINT	NOT NULL	AUTO_INCREMENT,
                                    name	VARCHAR(255)	NOT NULL,
    gram	INTEGER	NOT NULL,
    kcal	DECIMAL(8,2)	NOT NULL,
    carbo	DECIMAL(8,2)	NOT NULL,
    protein	DECIMAL(8,2)	NOT NULL,
    fat	DECIMAL(8,2)	NOT NULL,
    sodium	DECIMAL(10,2)	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS meal (
                                    id	BIGINT	NOT NULL	AUTO_INCREMENT ,
                                    type	ENUM('BREAKFAST','LUNCH','DINNER','SNACK')	NOT NULL,
    date	DATE	NOT NULL,
    created_at	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    member_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member (
                                      id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                      name	VARCHAR(255)	NULL,
    nickname	VARCHAR(255)	NULL,
    email	VARCHAR(255)	NOT NULL,
    pw	VARCHAR(255)	NOT NULL,
    phone	VARCHAR(255)	NULL,
    gender	varchar(1)	NULL	,
    birth	VARCHAR(255)	NULL,
    height	DECIMAL(5,2)	NULL,
    weight	DECIMAL(5,2)	NULL,
    body_metric	INT	NULL	,
    point	INT	NULL,
    created_at	DATETIME	NOT NULL,
    login_failure_count	int	NULL,
    login_lock_until	datetime	NULL	,
    quit_date	datetime	NULL,
    join_date	datetime	NULL,
    status	bigint	NOT NULL	DEFAULT 1,
    level	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS authorites (
                                          id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                          authurity	VARCHAR(255)	NOT NULL,
    description	varchar(255)	NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

-- 2. 독립 테이블 (다른 테이블을 참조하지 않는 테이블)
CREATE TABLE IF NOT EXISTS `exercise` (
                                          exercise_id INT NOT NULL AUTO_INCREMENT,
                                          member_id BIGINT NOT NULL,
                                          exercise_date DATE NOT NULL,
                                          exercise_type VARCHAR(100) NOT NULL,
    exercise_category VARCHAR(50),
    exercise_min INT NOT NULL,
    exercise_burned_kcal INT NOT NULL,
    exercise_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_exercise PRIMARY KEY (exercise_id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS bingo_board (
                                           id	INT	NOT NULL 	AUTO_INCREMENT	,
                                           title	VARCHAR(255)	NOT NULL,
    size	INT	NOT NULL,
    start_date	DATE	NOT NULL,
    end_date	DATE	NULL,
    created_at	DATETIME	NOT NULL,
    member_id	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS upload_file (
                                           id	INT	NOT NULL 	AUTO_INCREMENT	,
                                           mime_type	VARCHAR(255)	NULL,
    file_path	VARCHAR(255)	NOT NULL,
    created_at	DATETIME	NULL,
    State	VARCHAR(255)	NULL,
    original_file_name	VARCHAR(255)	NULL,
    re_file_name	VARCHAR(255)	NULL,
    member_id	bigint	NOT NULL,
    extend_fild_path_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_fileupload (
                                                id	INT	NOT NULL 	AUTO_INCREMENT	,
                                                name	VARCHAR(255)	NOT NULL,
    mime_type	VARCHAR(255)	NOT NULL,
    re_name	VARCHAR(255)	NULL,
    url	VARCHAR(255)	NOT NULL,
    create_at	DATETIME	NULL,
    extend_file_path_id	BIGINT	NOT NULL,
    gacha_event_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post_comment (
                                            id	INT	NOT NULL 	AUTO_INCREMENT	,
                                            content	VARCHAR(255)	NOT NULL,
    create_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
    post_id	INT	NOT NULL,
    member_id	INT	NOT NULL,
    member_parent_comment_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_rank (
                                           id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                           name	varchar(255)	NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post_tag (
                                        id	INT	NOT NULL 	AUTO_INCREMENT	,
                                        name	VARCHAR(255)	NULL,
    post_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS goal (
                                    id	INT	NOT NULL 	AUTO_INCREMENT	,
                                    type	ENUM('WEIGHT','CALORIE','MACRO')	NOT NULL,
    target_value	DECIMAL(10,2)	NULL,
    kcal_per_day	INT	NULL,
    protein_g	INT	NULL,
    fat_g	INT	NULL,
    carbs_g	INT	NULL,
    start_date	DATE	NOT NULL,
    end_date	DATE	NULL,
    created_at	DATETIME	NOT NULL,
    id2	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_prize (
                                           id	BIGINT	NOT NULL		AUTO_INCREMENT	,
                                           name	VARCHAR(100)	NOT NULL	,
    payload_json	JSON	NULL	,
    prize_type	ENUM('POINT', 'COUPON', 'ITEM', 'NOTHING', 'ETC')	NOT NULL	,
    rank	INT	NULL,
    created_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	,
    quantity	int	NULL	DEFAULT 0,
    gacha_event_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `diary` (
                                       `id` INT NOT NULL AUTO_INCREMENT,
                                       `day` DATETIME NOT NULL,
                                       `weight` INT NOT NULL,
                                       `mood` ENUM('아주좋음', '좋음', '보통', '나쁨', '아주나쁨'),
    `condition` VARCHAR(255) NOT NULL,
    `memo` VARCHAR(500) NOT NULL,
    `member_id` BIGINT NOT NULL,
    CONSTRAINT `pk_diary` PRIMARY KEY (`id`)
    ) ENGINE=InnoDB COMMENT='일기';

CREATE TABLE IF NOT EXISTS member_allergy (
                                              id	INT	NOT NULL	AUTO_INCREMENT,
                                              member_id	BIGINT	NOT NULL,
                                              allergy_id	INT	NOT NULL,
                                              PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS qna (
                                   id	BIGINT	NOT NULL	AUTO_INCREMENT	,
                                   title	VARCHAR(255)	NULL	,
    contents	VARCHAR(500)	NULL	,
    created_at	DATETIME	NULL	,
    member_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS refresh_token (
                                             id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                             token_hash	varchar(128)	NOT NULL,
    jti	varchar(64)	NULL UNIQUE,
    issued_at	datetime	NULL,
    expires_at	datetime	NULL,
    revoked	tinyint	NULL	DEFAULT 0,
    revoked_at	datetime	NULL,
    device_fp	varchar(255)	NULL,
    ip	varchar(255)	NULL,
    last_used_at	datetime	NULL,
    member_id	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS login_history (
                                             id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                             date	datetime	NOT NULL,
                                             come_in_ip	varchar(255)	NULL,
    before_path	varchar(255)	NULL,
    member_id	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS bingo_cell (
                                          id	INT	NOT NULL 	AUTO_INCREMENT	,
                                          row	INT	NOT NULL,
                                          col	INT	NOT NULL,
                                          label	VARCHAR(255)	NOT NULL,
    is_checked	TINYINT(1)	NOT NULL,
    checked_at	DATETIME	NULL,
    bingo_board_id	INT	NOT NULL,
    fileupload_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS calender (
                                        id	INT	NOT NULL	AUTO_INCREMENT ,
                                        cal_day	DATETIME	NULL	,
                                        badge_count	INT	NULL	,
                                        exercise_status	INT	NULL		,
                                        meal_status	INT	NULL		,
                                        diary_status	INT	NULL		,
                                        id2	BIGINT	NOT NULL		,
                                        PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `exercise_fileupload` (
                                                     upload_id INT NOT NULL AUTO_INCREMENT,
                                                     exercise_id INT NOT NULL,
                                                     file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(255),
    file_rename VARCHAR(255),
    file_path VARCHAR(255) NOT NULL,
    thumb_path VARCHAR(255),
    upload_order INT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_exercise_fileupload PRIMARY KEY (upload_id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS gacha_board_cell (
                                                id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
                                                status	ENUM('COVERED', 'OPENED')	NOT NULL	DEFAULT 'COVERED',
    opened_at	DATETIME	NULL,
    board_rows	INT	NULL,
    cols	INT	NULL,
    opened_count	INT	NULL,
    created_at	DATETIME	NULL,
    updated_at	DATETIME	NULL,
    gacha_prize_id	BIGINT	NOT NULL	,
    gacha_event_id	BIGINT	NOT NULL,
    member_id	bigint	NOT NULL	,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_event (
                                           id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
                                           start_at	DATETIME	NOT NULL	,
                                           point	INT	NULL	DEFAULT 0,
                                           end_at	DATETIME	NOT NULL	,
                                           status	ENUM('DRAFT', 'ACTIVE', 'PAUSED', 'ENDED')	NOT NULL	DEFAULT 'DRAFT'	,
    created_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	,
    event_id2	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS food_fileupload (
                                               id	INT	NOT NULL	AUTO_INCREMENT ,
                                               meal_id	BIGINT	NOT NULL	,
                                               name	VARCHAR(255)	NOT NULL,
    type	VARCHAR(255)	NOT NULL,
    re_name	VARCHAR(255)	NOT NULL,
    path	VARCHAR(255)	NOT NULL,
    create_at	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    upload_order	INT	NOT NULL,
    thumb_path	VARCHAR(255)	NOT NULL,
    extend_fild_path_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS point (
                                     id	BIGINT	NOT NULL AUTO_INCREMENT	,
                                     points	INT	NULL,
                                     distinction	ENUM('GET', 'USE')	NULL	,
    member_id BIGINT NOT NULL,
    diary_id	INT	NOT NULL	,
    calender_id	INT	NOT NULL,
    gacha_event_id	BIGINT	NOT NULL,
    bingo_board_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS login_failure_history (
                                                     id	bigint	NOT NULL AUTO_INCREMENT	,
                                                     failure_datetime	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                     failure_ip	varchar(255)	NULL,
    failure_reasone	VARCHAR(2000)	NULL,
    member_id BIGINT NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `report` (
                                        report_no BIGINT NOT NULL AUTO_INCREMENT,
                                        member_id BIGINT NOT NULL,
                                        member_id2 BIGINT NOT NULL,
                                        report_title VARCHAR(255) NOT NULL,
    report_content VARCHAR(255) NOT NULL,
    report_yn BOOLEAN NOT NULL,
    report_date DATETIME NOT NULL,
    report_source VARCHAR(255) NOT NULL,
    post_id INT,
    comment_id INT,
    admin_id BIGINT DEFAULT NULL,
    report_id INT NOT NULL,
    report_image_url VARCHAR(500),
    CONSTRAINT PK_report PRIMARY KEY (report_no)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS post_file (
                                         id	INT	NOT NULL 	AUTO_INCREMENT	,
                                         name	VARCHAR(255)	NULL,
    url	VARCHAR(255)	NOT NULL,
    mime_type	VARCHAR(255)	NULL,
    path	VARCHAR(255)	NOT NULL,
    created_at	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP ,
    state	VARCHAR(255)	NULL,
    re_name	VARCHAR(255)	NULL,
    post_id	INT	NOT NULL,
    extend_fild_path_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS diary_file (
                                          id	INT	NOT NULL	AUTO_INCREMENT	,
                                          mime	VARCHAR(255)	NULL	,
    path	VARCHAR(255)	NOT NULL	,
    created_at	DATETIME	NULL	,
    state	VARCHAR(255)	NULL	,
    original_file	VARCHAR(255)	NULL	,
    re_name	INT	NULL	,
    diary_id	INT	NOT NULL	,
    extend_fild_path_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS allergy (
                                       id	INT	NOT NULL	AUTO_INCREMENT ,
                                       name	VARCHAR(255)	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post (
                                    id	INT	NOT NULL 	AUTO_INCREMENT	,
                                    title	VARCHAR(255)	NOT NULL,
    content	VARCHAR(255)	NULL,
    visibility	TINYINT(1)	NULL	DEFAULT 0	,
    created_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP ,
    member_id	bigint	NOT NULL,
    tag_id	INT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `report_base` (
                                             report_base_id INT NOT NULL AUTO_INCREMENT,
                                             report_title VARCHAR(255) NOT NULL,
    report_base_count INT NOT NULL,
    report_base_day_of_ban INT DEFAULT 0,
    CONSTRAINT PK_report_base PRIMARY KEY (report_base_id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS post_like (
                                         id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                         like_created	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP ,
                                         member_id	bigint	NOT NULL,
                                         post_id	INT	NOT NULL,
                                         PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tag (
                                   id	INT	NOT NULL		AUTO_INCREMENT	,
                                   name	VARCHAR(255)	NOT NULL	,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ai_diet (
                                       id	BIGINT	NOT NULL AUTO_INCREMENT	,
                                       type	ENUM('BREAKFAST','LUNCH','DINNER','SNACK') NOT NULL,
    total_kcal	DECIMAL(8,2) NOT NULL,
    kcal	DECIMAL(8,2)	NOT NULL,
    total_protein	DECIMAL(8,2)	NOT NULL,
    total_fat	DECIMAL(8,2)	NOT NULL,
    created_at	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
    name	VARCHAR(255)	NOT NULL,
    member_id	bigint	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_reward_grant (
                                                  id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
                                                  grant_status	ENUM('QUEUED', 'GRANTED', 'FAILED')	NOT NULL	DEFAULT 'QUEUED'	,
    granted_at	DATETIME	NULL	,
    created_at	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	,
    gacha_board_cell_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS bingo_fileupload (
                                                id	INT	NOT NULL 	AUTO_INCREMENT	,
                                                name	VARCHAR(500)	NOT NULL,
    mime_type	VARCHAR(500)	NOT NULL,
    re_name	VARCHAR(255)	NULL,
    url	VARCHAR(255)	NOT NULL,
    created_at	DATETIME	NULL,
    extend_fild_path_id	BIGINT	NOT NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_status (
                                             id	bigint	NOT NULL 	AUTO_INCREMENT,
                                             status	varchar(255)	NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `report_fileupload` (
                                                   report_upload_id INT NOT NULL AUTO_INCREMENT,
                                                   report_no BIGINT NOT NULL,
                                                   report_fileupload_name VARCHAR(255),
    report_fileupload_type VARCHAR(255),
    report_fileupload_rename VARCHAR(255),
    report_fileupload_path VARCHAR(255),
    report_fileupload_thumb_path VARCHAR(255),
    report_fileupload_upload_order INT DEFAULT 1,
    report_fileupload_create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_report_fileupload PRIMARY KEY (report_upload_id)
    ) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS comment_like (
                                            id	bigint	NOT NULL 	AUTO_INCREMENT,
                                            create_at	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP ,
                                            member_id	bigint	NOT NULL,
                                            post_comment_id	INT	NOT NULL,
                                            PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS qna_comment (
                                           id	BIGINT	NOT NULL	AUTO_INCREMENT	,
                                           comment	VARCHAR(500)	NULL	,
    created_at	DATETIME	NULL	,
    qna_id	BIGINT	NOT NULL	,
    member_id	BIGINT	NOT NULL	,
    id2	BIGINT	NOT NULL		,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ban (
                                   id	bigint	NOT NULL 	AUTO_INCREMENT	,
                                   startDate	DATETIME	NOT NULL,
                                   endDate	DATETIME	NOT NULL,
                                   admin_id	bigint	NOT NULL,
                                   member_id	bigint	NOT NULL,
                                   report_no	bigint	NOT NULL,
                                   PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS food_allergy (
                                            id	BIGINT	NOT NULL	AUTO_INCREMENT ,
                                            meal_id	BIGINT	NOT NULL,
                                            allergy_id	BIGINT	NOT NULL,
                                            PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS extend_file_path (
                                                id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
                                                url_path	VARCHAR(255)	NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_reset (
                                           id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
                                           name	VARCHAR(255)	NULL	,
    use_point	int	NULL,
    PRIMARY KEY (id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS gacha_quantity (
                                              id	BIGINT	NOT NULL		AUTO_INCREMENT	,
                                              count	INT	NULL,
                                              PRIMARY KEY (id)
    ) ENGINE=InnoDB;

-- 3. 자식 테이블 (다른 테이블을 참조하는 테이블)
CREATE TABLE IF NOT EXISTS meal_food (
                                         meal_id	BIGINT	NOT NULL,
                                         food_id	BIGINT	NOT NULL,
                                         PRIMARY KEY (meal_id, food_id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_authority (
                                                member_id	bigint	NOT NULL,
                                                authories_id	bigint	NOT NULL,
                                                PRIMARY KEY (member_id, authories_id)
    ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `black_list` (
                                            member_id BIGINT NOT NULL,
                                            create_date DATETIME NOT NULL,
                                            reason VARCHAR(2000) NOT NULL,
    admin_id BIGINT,
    CONSTRAINT PK_black_list PRIMARY KEY (member_id)
    ) ENGINE=INNODB;

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

CREATE TABLE `calender` (
                            `id` BIGINT NOT NULL AUTO_INCREMENT,
                            `cal_day` DATETIME NOT NULL,
                            `badge_count` INT NOT NULL,
                            `exercise_status` INT NOT NULL DEFAULT 0,
                            `meal_status` INT NOT NULL DEFAULT 0,
                            `diary_status` INT NOT NULL DEFAULT 0,
                            `member_id` BIGINT NOT NULL DEFAULT 0,
                            CONSTRAINT `pk_calender` PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='캘린더';

-- ----------------------------
-- Foreign Key 제약 조건 추가
-- ----------------------------
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

ALTER TABLE member_authority ADD CONSTRAINT FK_member_TO_member_authority_1 FOREIGN KEY (
                                                                                         member_id
    )
    REFERENCES member (
                       id
        );

ALTER TABLE member_authority ADD CONSTRAINT FK_authorites_TO_member_authority_1 FOREIGN KEY (
                                                                                             authories_id
    )
    REFERENCES authorites (
                           id
        );

ALTER TABLE black_list ADD CONSTRAINT FK_member_TO_black_list_1 FOREIGN KEY (
                                                                             member_id
    )
    REFERENCES member (
                       id
        );

ALTER TABLE diary_file add CONSTRAINT `fk_diary_to_diary_file_1` FOREIGN KEY (`diary_id`) REFERENCES `diary` (`id`);

ALTER TABLE diary_file add CONSTRAINT `fk_extend_file_path_to_diary_file_1` FOREIGN KEY (`extend_file_path_id`) REFERENCES `extend_file_path` (`id`);

ALTER TABLE qna_comment add CONSTRAINT `fk_qna_to_qna_comment_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`);

ALTER TABLE qna_comment add CONSTRAINT `fk_member_to_qna_comment_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

ALTER TABLE qna_comment add CONSTRAINT `fk_qna_comment_to_qna_comment_1` FOREIGN KEY (`parent_comment_id`) REFERENCES `qna_comment` (`id`);

ALTER TABLE calender add CONSTRAINT `fk_member_to_calender_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

ALTER TABLE qna add CONSTRAINT `fk_member_to_qna_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

ALTER TABLE diary add CONSTRAINT `fk_member_to_diary_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`);

ALTER TABLE exercise_fileupload ADD CONSTRAINT fk_fileupload_exercise FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id) ON DELETE CASCADE;

ALTER TABLE report ADD CONSTRAINT fk_report_report_base FOREIGN KEY (report_id) REFERENCES report_base(report_base_id);

ALTER TABLE report_fileupload ADD CONSTRAINT fk_report_fileupload_report FOREIGN KEY (report_no) REFERENCES report(report_no) ON DELETE CASCADE;

ALTER TABLE black_list ADD CONSTRAINT fk_blacklist_admin FOREIGN KEY (admin_id) REFERENCES member(member_no);




INSERT INTO `diary` (`day`, `weight`, `mood`, `condition`, `memo`, `member_id`) VALUES
                                                                                    ('2025-11-01', 70, '좋음', '컨디션 양호', '오늘은 아침 일찍 일어나서 산책을 다녀왔다. 공기가 차가웠지만 상쾌해서 하루를 기분 좋게 시작할 수 있었다. 점심에는 가벼운 샐러드를 먹고 오후에는 책을 읽으며 여유로운 시간을 보냈다.', 1),
                                                                                    ('2025-11-02', 69, '보통', '피곤함', '주말이라 늦잠을 잤다. 전날 늦게까지 영화를 봐서인지 하루 종일 조금 피곤했다. 오후에는 커피를 마시며 잠을 쫓았고, 저녁에는 간단히 파스타를 해먹었다. 특별한 일은 없지만 평범한 하루였다.', 1),
                                                                                    ('2025-11-03', 68, '아주좋음', '최상', '출근길에 하늘이 유난히 맑았다. 일도 잘 풀리고 팀원들과의 회의도 순조로웠다. 저녁에는 오랜만에 친구를 만나 즐겁게 수다를 떨었다. 모든 게 잘 흘러가는 하루라 행복하다.', 2),
                                                                                    ('2025-11-04', 70, '나쁨', '두통', '아침부터 머리가 아팠다. 잠을 충분히 못 잔 탓인 것 같다. 커피를 마셔도 별로 나아지지 않았다. 일을 하다가 집중이 잘 안 돼서 조퇴하고 집에 돌아와 푹 쉬었다.', 3),
                                                                                    ('2025-11-05', 71, '보통', '보통', '오늘은 특별한 감정 없이 그냥 평범한 하루였다. 회사에서 일하고 점심에는 동료들과 식당에 다녀왔다. 저녁에는 집에서 드라마를 보며 시간을 보냈다.', 2),
                                                                                    ('2025-11-06', 69, '좋음', '활기참', '아침에 일어나자마자 운동을 했다. 땀을 흘리니 기분이 상쾌했다. 점심엔 샐러드와 닭가슴살을 먹었고, 오후에는 프로젝트 진행 상황을 점검했다. 하루를 잘 마무리했다.', 4),
                                                                                    ('2025-11-07', 70, '아주좋음', '매우 좋음', '오늘은 기다리던 여행을 다녀왔다. 바다를 보며 걷는 동안 마음이 한결 편안해졌다. 날씨도 완벽했고, 사진도 많이 찍었다. 행복한 기억으로 남을 하루였다.', 5),
                                                                                    ('2025-11-08', 68, '보통', '괜찮음', '주말이라 집에서 푹 쉬었다. 밀린 빨래를 하고, 방 청소도 했다. 저녁에는 따뜻한 차를 마시며 독서를 했다. 조용하지만 만족스러운 하루였다.', 3),
                                                                                    ('2025-11-09', 67, '좋음', '건강함', '오늘은 간헐적 단식을 유지하며 가벼운 요가를 했다. 몸이 훨씬 가벼워진 느낌이다. 저녁에는 가족들과 함께 식사하면서 이런저런 이야기를 나눴다.', 6),
                                                                                    ('2025-11-10', 70, '아주나쁨', '매우 피곤', '야근이 길어져서 집에 돌아온 게 새벽이었다. 피곤해서 저녁도 거르고 바로 잠들었다. 몸이 무겁고 정신도 흐릿하다. 내일은 꼭 일찍 퇴근해야겠다.', 1);


INSERT INTO `diary_file` (`mime`, `path`, `created_at`, `state`, `original_file`, `rename`, `diary_id`, `extend_file_path_id`) VALUES
                                                                                                                                   ('image/png', '/uploads/diary/1.png', '2025-11-01 10:00:00', 'active', '1.png', 1001, 1, 1),
                                                                                                                                   ('image/jpg', '/uploads/diary/2.jpg', '2025-11-02 09:00:00', 'active', '2.jpg', 1002, 2, 1),
                                                                                                                                   ('image/png', '/uploads/diary/3.png', '2025-11-03 08:30:00', 'active', '3.png', 1003, 3, 2),
                                                                                                                                   ('image/jpg', '/uploads/diary/4.jpg', '2025-11-04 11:00:00', 'inactive', '4.jpg', 1004, 4, 3),
                                                                                                                                   ('image/png', '/uploads/diary/5.png', '2025-11-05 10:30:00', 'active', '5.png', 1005, 5, 2),
                                                                                                                                   ('image/jpg', '/uploads/diary/6.jpg', '2025-11-06 09:10:00', 'deleted', '6.jpg', 1006, 6, 3),
                                                                                                                                   ('image/png', '/uploads/diary/7.png', '2025-11-07 13:00:00', 'active', '7.png', 1007, 7, 1),
                                                                                                                                   ('image/png', '/uploads/diary/8.png', '2025-11-08 15:45:00', 'active', '8.png', 1008, 8, 1),
                                                                                                                                   ('image/jpg', '/uploads/diary/9.jpg', '2025-11-09 09:25:00', 'active', '9.jpg', 1009, 9, 3),
                                                                                                                                   ('image/png', '/uploads/diary/10.png', '2025-11-10 22:15:00', 'active', '10.png', 1010, 10, 2);


INSERT INTO `qna` (`title`, `contents`, `created_at`, `member_id`) VALUES
                                                                       ('운동 루틴 추천', '체지방 감량에 좋은 루틴이 있을까요?', '2025-11-01 10:00:00', 1),
                                                                       ('단백질 섭취량', '운동 후 단백질 섭취량은 어느 정도가 적당한가요?', '2025-11-02 09:00:00', 2),
                                                                       ('다이어트 정체기', '체중이 줄지 않을 때 어떻게 해야 할까요?', '2025-11-03 08:30:00', 3),
                                                                       ('헬스장 추천', '서울 강남 근처 좋은 헬스장 추천 부탁드려요.', '2025-11-04 12:00:00', 4),
                                                                       ('아침 식사 중요성', '아침을 꼭 먹어야 하나요?', '2025-11-05 07:45:00', 5),
                                                                       ('근육통 완화', '운동 후 근육통 줄이는 법 알려주세요.', '2025-11-06 11:10:00', 2),
                                                                       ('유산소 시간', '하루 유산소는 몇 분이 좋을까요?', '2025-11-07 14:20:00', 3),
                                                                       ('체중계 정확도', '체중계가 자꾸 다르게 나와요.', '2025-11-08 15:00:00', 6),
                                                                       ('식단 관리 앱 추천', '좋은 식단 관리 앱 있을까요?', '2025-11-09 09:45:00', 4),
                                                                       ('수면과 다이어트', '수면 부족이 체중 감량에 영향이 있나요?', '2025-11-10 23:30:00', 5);


INSERT INTO `qna_comment` (`comment`, `created_at`, `qna_id`, `member_id`, `parent_comment_id`) VALUES
                                                                                                    ('좋은 질문이에요! 저도 궁금했어요.', '2025-11-01 11:00:00', 1, 2, NULL),
                                                                                                    ('단백질은 체중×1.6g 정도 추천드려요.', '2025-11-02 10:00:00', 2, 3, NULL),
                                                                                                    ('저는 아침을 꼭 챙겨먹어요!', '2025-11-05 08:00:00', 5, 4, NULL),
                                                                                                    ('운동 후 스트레칭 꼭 하세요.', '2025-11-06 12:00:00', 6, 5, NULL),
                                                                                                    ('체중계 브랜드마다 조금 달라요.', '2025-11-08 15:30:00', 8, 1, NULL),
                                                                                                    ('정체기면 식단을 바꿔보세요.', '2025-11-03 09:00:00', 3, 2, NULL),
                                                                                                    ('좋은 헬스장 많아요! PM헬스 추천', '2025-11-04 13:00:00', 4, 3, NULL),
                                                                                                    ('저도 같은 고민이에요 ㅠㅠ', '2025-11-09 10:00:00', 9, 4, NULL),
                                                                                                    ('잠 부족하면 코르티솔 올라갑니다.', '2025-11-10 23:45:00', 10, 5, NULL),
                                                                                                    ('위 댓글에 동의합니다!', '2025-11-02 10:30:00', 2, 6, 2);


INSERT INTO `calender` (`cal_day`, `badge_count`, `exercise_status`, `meal_status`, `diary_status`, `member_id`) VALUES
                                                                                                                     ('2025-11-01', 3, 1, 1, 1, 1),
                                                                                                                     ('2025-11-02', 2, 0, 1, 1, 1),
                                                                                                                     ('2025-11-03', 4, 1, 1, 1, 2),
                                                                                                                     ('2025-11-04', 1, 0, 1, 0, 3),
                                                                                                                     ('2025-11-05', 3, 1, 1, 1, 4),
                                                                                                                     ('2025-11-06', 2, 1, 0, 1, 2),
                                                                                                                     ('2025-11-07', 5, 1, 1, 1, 5),
                                                                                                                     ('2025-11-08', 1, 0, 0, 1, 3),
                                                                                                                     ('2025-11-09', 3, 1, 1, 0, 6),
                                                                                                                     ('2025-11-10', 4, 1, 1, 1, 1);

INSERT INTO exercise
(member_id, exercise_date, exercise_type, exercise_category, exercise_min, exercise_burned_kcal)
VALUES
    (1, '2025-11-01', '조깅', '유산소', 30, 210),
    (1, '2025-11-02', '자전거 타기', '유산소', 45, 340),
    (1, '2025-11-03', '스쿼트', '무산소', 20, 160),
    (1, '2025-11-04', '요가', '스트레칭', 40, 120),

    (2, '2025-11-01', '수영', '유산소', 60, 430),
    (2, '2025-11-02', '팔굽혀펴기', '무산소', 15, 90),
    (2, '2025-11-03', '줄넘기', '유산소', 25, 210),
    (2, '2025-11-04', '복근운동', '무산소', 30, 180),

    (3, '2025-11-01', '런닝머신', '유산소', 35, 260),
    (3, '2025-11-02', '등운동', '무산소', 25, 190),
    (3, '2025-11-03', '요가', '스트레칭', 30, 100),
    (3, '2025-11-04', '사이클', '유산소', 40, 300),

    (4, '2025-11-01', '스트레칭', '스트레칭', 15, 50),
    (4, '2025-11-02', '플랭크', '무산소', 10, 70),
    (4, '2025-11-03', '필라테스', '스트레칭', 40, 140),
    (4, '2025-11-04', '걷기', '유산소', 50, 180),

    (5, '2025-11-01', '조깅', '유산소', 20, 150),
    (5, '2025-11-02', '사이클', '유산소', 30, 240),
    (5, '2025-11-03', '복근운동', '무산소', 25, 160),
    (5, '2025-11-04', '요가', '스트레칭', 30, 100),

    (6, '2025-11-01', '벤치프레스', '무산소', 20, 190),
    (6, '2025-11-02', '사이클', '유산소', 40, 290),
    (6, '2025-11-03', '달리기', '유산소', 35, 260),

    (7, '2025-11-01', '스쿼트', '무산소', 15, 130),
    (7, '2025-11-02', '줄넘기', '유산소', 20, 200),
    (7, '2025-11-03', '걷기', '유산소', 30, 130),

    (8, '2025-11-01', '자전거 타기', '유산소', 40, 330),
    (8, '2025-11-02', '플랭크', '무산소', 15, 90),
    (8, '2025-11-03', '스트레칭', '스트레칭', 20, 60),
    (8, '2025-11-04', '팔굽혀펴기', '무산소', 15, 80);

INSERT INTO exercise_fileupload
(exercise_id, file_name, file_type, file_rename, file_path, thumb_path, upload_order)
VALUES
    (1,  'jogging1.jpg',   'image/jpeg', 'jogging_001.jpg',   '/uploads/exercise/jogging_001.jpg',   '/uploads/exercise/thumb_jogging_001.jpg',   1),
    (2,  'bike1.jpg',      'image/jpeg', 'bike_001.jpg',      '/uploads/exercise/bike_001.jpg',      '/uploads/exercise/thumb_bike_001.jpg',      1),
    (3,  'squat1.jpg',     'image/jpeg', 'squat_001.jpg',     '/uploads/exercise/squat_001.jpg',     '/uploads/exercise/thumb_squat_001.jpg',     1),
    (4,  'yoga1.jpg',      'image/jpeg', 'yoga_001.jpg',      '/uploads/exercise/yoga_001.jpg',      '/uploads/exercise/thumb_yoga_001.jpg',      1),
    (5,  'swim1.jpg',      'image/jpeg', 'swim_001.jpg',      '/uploads/exercise/swim_001.jpg',      '/uploads/exercise/thumb_swim_001.jpg',      1),
    (6,  'pushup1.jpg',    'image/jpeg', 'pushup_001.jpg',    '/uploads/exercise/pushup_001.jpg',    '/uploads/exercise/thumb_pushup_001.jpg',    1),
    (7,  'jump1.jpg',      'image/jpeg', 'jump_001.jpg',      '/uploads/exercise/jump_001.jpg',      '/uploads/exercise/thumb_jump_001.jpg',      1),
    (8,  'abs1.jpg',       'image/jpeg', 'abs_001.jpg',       '/uploads/exercise/abs_001.jpg',       '/uploads/exercise/thumb_abs_001.jpg',       1),
    (9,  'treadmill1.jpg', 'image/jpeg', 'treadmill_001.jpg', '/uploads/exercise/treadmill_001.jpg', '/uploads/exercise/thumb_treadmill_001.jpg', 1),
    (10, 'back1.jpg',      'image/jpeg', 'back_001.jpg',      '/uploads/exercise/back_001.jpg',      '/uploads/exercise/thumb_back_001.jpg',      1),
    (11, 'yoga2.jpg',      'image/jpeg', 'yoga_002.jpg',      '/uploads/exercise/yoga_002.jpg',      '/uploads/exercise/thumb_yoga_002.jpg',      1),
    (12, 'cycle1.jpg',     'image/jpeg', 'cycle_001.jpg',     '/uploads/exercise/cycle_001.jpg',     '/uploads/exercise/thumb_cycle_001.jpg',     1),
    (13, 'stretch1.jpg',   'image/jpeg', 'stretch_001.jpg',   '/uploads/exercise/stretch_001.jpg',   '/uploads/exercise/thumb_stretch_001.jpg',   1),
    (14, 'plank1.jpg',     'image/jpeg', 'plank_001.jpg',     '/uploads/exercise/plank_001.jpg',     '/uploads/exercise/thumb_plank_001.jpg',     1),
    (15, 'pilates1.jpg',   'image/jpeg', 'pilates_001.jpg',   '/uploads/exercise/pilates_001.jpg',   '/uploads/exercise/thumb_pilates_001.jpg',   1),
    (16, 'walk1.jpg',      'image/jpeg', 'walk_001.jpg',      '/uploads/exercise/walk_001.jpg',      '/uploads/exercise/thumb_walk_001.jpg',      1),
    (17, 'jogging2.jpg',   'image/jpeg', 'jogging_002.jpg',   '/uploads/exercise/jogging_002.jpg',   '/uploads/exercise/thumb_jogging_002.jpg',   1),
    (18, 'cycle2.jpg',     'image/jpeg', 'cycle_002.jpg',     '/uploads/exercise/cycle_002.jpg',     '/uploads/exercise/thumb_cycle_002.jpg',     1),
    (19, 'abs2.jpg',       'image/jpeg', 'abs_002.jpg',       '/uploads/exercise/abs_002.jpg',       '/uploads/exercise/thumb_abs_002.jpg',       1),
    (20, 'yoga3.jpg',      'image/jpeg', 'yoga_003.jpg',      '/uploads/exercise/yoga_003.jpg',      '/uploads/exercise/thumb_yoga_003.jpg',      1),
    (21, 'bench1.jpg',     'image/jpeg', 'bench_001.jpg',     '/uploads/exercise/bench_001.jpg',     '/uploads/exercise/thumb_bench_001.jpg',     1),
    (22, 'cycle3.jpg',     'image/jpeg', 'cycle_003.jpg',     '/uploads/exercise/cycle_003.jpg',     '/uploads/exercise/thumb_cycle_003.jpg',     1),
    (23, 'run1.jpg',       'image/jpeg', 'run_001.jpg',       '/uploads/exercise/run_001.jpg',       '/uploads/exercise/thumb_run_001.jpg',       1),
    (24, 'squat2.jpg',     'image/jpeg', 'squat_002.jpg',     '/uploads/exercise/squat_002.jpg',     '/uploads/exercise/thumb_squat_002.jpg',     1),
    (25, 'jump2.jpg',      'image/jpeg', 'jump_002.jpg',      '/uploads/exercise/jump_002.jpg',      '/uploads/exercise/thumb_jump_002.jpg',      1),
    (26, 'walk2.jpg',      'image/jpeg', 'walk_002.jpg',      '/uploads/exercise/walk_002.jpg',      '/uploads/exercise/thumb_walk_002.jpg',      1),
    (27, 'bike2.jpg',      'image/jpeg', 'bike_002.jpg',      '/uploads/exercise/bike_002.jpg',      '/uploads/exercise/thumb_bike_002.jpg',      1),
    (28, 'plank2.jpg',     'image/jpeg', 'plank_002.jpg',     '/uploads/exercise/plank_002.jpg',     '/uploads/exercise/thumb_plank_002.jpg',     1),
    (29, 'stretch2.jpg',   'image/jpeg', 'stretch_002.jpg',   '/uploads/exercise/stretch_002.jpg',   '/uploads/exercise/thumb_stretch_002.jpg',   1),
    (30, 'pushup2.jpg',    'image/jpeg', 'pushup_002.jpg',    '/uploads/exercise/pushup_002.jpg',    '/uploads/exercise/thumb_pushup_002.jpg',    1);

INSERT INTO report_base (report_title, report_base_count, report_base_day_of_ban)
VALUES
    ('욕설', 3, 7), ('도배', 5, 3), ('사기', 1, 30), ('음란물', 1, 15), ('허위사실', 2, 10),
    ('스팸', 5, 5), ('괴롭힘', 2, 14), ('기타', 5, 1), ('명예훼손', 2, 14), ('불법 광고', 3, 10);

INSERT INTO report
(member_id, member_id2, report_title, report_content, report_yn, report_date,
 report_source, post_id, comment_id, admin_id, report_id, report_image_url)
VALUES
    (1, 2, '욕설 신고', '댓글에서 욕설 사용', TRUE, NOW(), '댓글', 11, 1001, NULL, 1, '/img/report1.png'),
    (2, 3, '도배 신고', '같은 글을 반복 게시', TRUE, NOW(), '게시글', 12, NULL, NULL, 2, '/img/report2.png'),
    (3, 4, '사기 신고', '물품 거래 사기 발생', TRUE, NOW(), '거래', NULL, NULL, NULL, 3, '/img/report3.png'),
    (4, 5, '음란물 신고', '부적절한 사진 업로드', TRUE, NOW(), '사진', 14, NULL, NULL, 4, '/img/report4.png'),
    (5, 6, '허위사실 신고', '허위 정보 유포', TRUE, NOW(), '게시글', 15, NULL, NULL, 5, '/img/report5.png'),
    (6, 7, '스팸 신고', '광고성 댓글', TRUE, NOW(), '댓글', NULL, 2001, NULL, 6, '/img/report6.png'),
    (7, 8, '괴롭힘 신고', '지속적 비난 행위', TRUE, NOW(), 'DM', NULL, NULL, NULL, 7, '/img/report7.png'),
    (8, 9, '기타 신고', '기타 사유로 신고', TRUE, NOW(), '게시글', 17, NULL, NULL, 8, '/img/report8.png'),
    (9, 10, '명예훼손 신고', '비방 글 작성', TRUE, NOW(), '게시글', 18, NULL, NULL, 9, '/img/report9.png'),
    (10, 1, '불법 광고 신고', '불법 사이트 홍보', TRUE, NOW(), '댓글', NULL, 3001, NULL, 10, '/img/report10.png');

INSERT INTO report_fileupload
(report_no, report_fileupload_name, report_fileupload_type, report_fileupload_rename,
 report_fileupload_path, report_fileupload_thumb_path, report_fileupload_upload_order)
VALUES
    (1, 'report1.jpg', 'image/jpeg', 'report1_001.jpg', '/upload/report1.jpg', '/upload/thumb_report1.jpg', 1),
    (2, 'report2.jpg', 'image/jpeg', 'report2_001.jpg', '/upload/report2.jpg', '/upload/thumb_report2.jpg', 1),
    (3, 'report3.png', 'image/png', 'report3_001.png', '/upload/report3.png', '/upload/thumb_report3.png', 1),
    (4, 'report4.jpg', 'image/jpeg', 'report4_001.jpg', '/upload/report4.jpg', '/upload/thumb_report4.jpg', 1),
    (5, 'report5.png', 'image/png', 'report5_001.png', '/upload/report5.png', '/upload/thumb_report5.png', 1),
    (6, 'report6.png', 'image/png', 'report6_001.png', '/upload/report6.png', '/upload/thumb_report6.png', 1),
    (7, 'report7.jpg', 'image/jpeg', 'report7_001.jpg', '/upload/report7.jpg', '/upload/thumb_report7.jpg', 1),
    (8, 'report8.png', 'image/png', 'report8_001.png', '/upload/report8.png', '/upload/thumb_report8.png', 1),
    (9, 'report9.png', 'image/png', 'report9_001.png', '/upload/report9.png', '/upload/thumb_report9.png', 1),
    (10, 'report10.jpg', 'image/jpeg', 'report10_001.jpg', '/upload/report10.jpg', '/upload/thumb_report10.jpg', 1);

INSERT INTO black_list (member_id, create_date, reason, admin_id)
VALUES
    (1, NOW(), '욕설 3회 누적', 10),
    (3, NOW(), '사기 행위 적발', 10);
