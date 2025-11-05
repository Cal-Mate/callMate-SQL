/* ======================================================================
   테이블 삭제 DDL (의존 역순)
   ====================================================================== */
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS gacha_reward_grant;
DROP TABLE IF EXISTS gacha_board_cell;
DROP TABLE IF EXISTS gacha_fileupload;
DROP TABLE IF EXISTS gacha_quantity;
DROP TABLE IF EXISTS gacha_prize;
DROP TABLE IF EXISTS gacha_event;

DROP TABLE IF EXISTS bingo_fileupload;
DROP TABLE IF EXISTS bingo_cell;
DROP TABLE IF EXISTS bingo_board;

DROP TABLE IF EXISTS point;

DROP TABLE IF EXISTS gacha_reset;

DROP TABLE IF EXISTS member;

SET FOREIGN_KEY_CHECKS = 1;


/* ======================================================================
   테이블 생성 DDL
   ====================================================================== */
/* BINGO_BOARD */
CREATE TABLE `bingo_board` (
                               `id` INT NOT NULL,
                               `title` VARCHAR(255) NOT NULL,
                               `size` INT NOT NULL,
                               `start_date` DATE NOT NULL,
                               `end_date` DATE NULL,
                               `created_at` DATETIME NOT NULL,
                               `member_id` BIGINT NOT NULL,
                               CONSTRAINT pk_bingo_board_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '빙고판';

/* BINGO_CELL */
CREATE TABLE `bingo_cell` (
                              `id` INT NOT NULL,
                              `row` INT NOT NULL,
                              `col` INT NOT NULL,
                              `label` VARCHAR(255) NOT NULL,
                              `is_checked` TINYINT(1) NOT NULL,
                              `checked_at` DATETIME NULL,
                              `bingo_board_id` INT NOT NULL,
                              CONSTRAINT ck_bingo_cell_is_checked CHECK (`is_checked` IN (0,1)),
                              CONSTRAINT pk_bingo_cell_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '빙고칸';


/* BINGO_FILEUPLOAD */
CREATE TABLE `bingo_fileupload` (
                                    `id` INT NOT NULL,
                                    `name` VARCHAR(500) NOT NULL,
                                    `mime_type` VARCHAR(500) NOT NULL,
                                    `rename` VARCHAR(255) NULL,
                                    `path` VARCHAR(255) NOT NULL,
                                    `created_at` DATETIME NULL,
                                    `bingo_cell_id` INT NOT NULL,
                                    `extend_file_path_id` INT NOT NULL,
                                    CONSTRAINT pk_bingo_fileupload_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '빙고_파일업로드';


/* GACHA_RESET (리셋 정책 마스터) */
CREATE TABLE `gacha_reset` (
                               `id` BIGINT NOT NULL,
                               `name` VARCHAR(255) NULL COMMENT '1: 1등뽑히면 리셋, 2: 모든 경품 뽑히면 리셋, 3: 기간 지나면 리셋',
                               `use_point` INT NULL COMMENT '사용포인트',
                               CONSTRAINT pk_gacha_reset_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기_리셋기준';


/* GACHA_EVENT */
CREATE TABLE `gacha_event` (
                               `id` BIGINT NOT NULL,
                               `start_at` DATETIME NOT NULL COMMENT '시작일시',
                               `point` INT NULL DEFAULT 0,
                               `end_at` DATETIME NOT NULL COMMENT '종료일시',
                               `status` ENUM('DRAFT','ACTIVE','PAUSED','ENDED') NOT NULL DEFAULT 'DRAFT' COMMENT '상태(DRAFT:작성중, ACTIVE:진행중, PAUSED:일시중지, ENDED:종료)',
                               `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                               `event_id2` BIGINT NOT NULL COMMENT '리셋 정책 ID',
                               CONSTRAINT pk_gacha_event_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기';


/* GACHA_PRIZE */
CREATE TABLE `gacha_prize` (
                               `id` BIGINT NOT NULL COMMENT '경품ID',
                               `name` VARCHAR(100) NOT NULL COMMENT '경품명',
                               `payload_json` JSON NULL COMMENT '경품내용(JSON: 포인트금액/쿠폰코드/아이템식별 등)',
                               `prize_type` ENUM('POINT','COUPON','ITEM','NOTHING','ETC') NOT NULL COMMENT '경품종류(포인트/쿠폰/아이템/꽝/기타)',
                               `rank` INT NULL,
                               `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                               `quantity` INT NULL DEFAULT 0,
                               `gacha_event_id` BIGINT NOT NULL,
                               CONSTRAINT pk_gacha_prize_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기상품';


/* GACHA_QUANTITY (경품 재고 수량 - 경품ID 1:1) */
CREATE TABLE `gacha_quantity` (
                                  `id` BIGINT NOT NULL COMMENT '경품ID',
                                  `count` INT NULL,
                                  CONSTRAINT pk_gacha_quantity_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기잔여수량';


/* GACHA_BOARD_CELL (사용자별 보드 셀 상태) */
CREATE TABLE `gacha_board_cell` (
                                    `id` BIGINT NOT NULL,
                                    `status` ENUM('COVERED','OPENED') NOT NULL DEFAULT 'COVERED',
                                    `opened_at` DATETIME NULL,
                                    `rows` INT NULL,
                                    `cols` INT NULL,
                                    `opened_count` INT NULL,
                                    `created_at` DATETIME NULL,
                                    `updated_at` DATETIME NULL,
                                    `gacha_prize_id` BIGINT NOT NULL COMMENT '경품ID',
                                    `gacha_event_id` BIGINT NOT NULL,
                                    `member_id` BIGINT NOT NULL COMMENT '해당 칸을 오픈 한 회원ID',
                                    CONSTRAINT pk_gacha_board_cell_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기보드칸';

/* gacha_draw_log (뽑기실행로그) */
CREATE TABLE `gacha_draw_log` (
                                  `id` BIGINT NOT NULL,
                                  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                                  CONSTRAINT pk_gacha_draw_log_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기실행로그';

/* GACHA_REWARD_GRANT (지급 로그) */
CREATE TABLE `gacha_reward_grant` (
                                      `id` BIGINT NOT NULL,
                                      `grant_status` ENUM('QUEUED','GRANTED','FAILED') NOT NULL DEFAULT 'QUEUED' COMMENT '지급상태',
                                      `granted_at` DATETIME NULL COMMENT '지급일시',
                                      `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                                      `gacha_board_cell_id` BIGINT NOT NULL,
                                      CONSTRAINT pk_gacha_reward_grant_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기경품지급로그';


/* GACHA_FILEUPLOAD */
CREATE TABLE `gacha_fileupload` (
                                    `id` INT NOT NULL,
                                    `extend_file_path_id` BIGINT NOT NULL,
                                    `gacha_event_id` BIGINT NOT NULL,
                                    `name` VARCHAR(255) NOT NULL,
                                    `mime_type` VARCHAR(255) NOT NULL,
                                    `re_name` VARCHAR(255) NULL,
                                    `url` VARCHAR(255) NOT NULL,
                                    `create_at` DATETIME NULL,
                                    CONSTRAINT pk_gacha_fileupload_id PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT '뽑기_파일업로드';


/* POINT (적립/사용 내역) */
CREATE TABLE `point` (
                         `point_id` BIGINT NOT NULL,
                         `point` INT NULL,
                         `distinction` ENUM('EARN','USE') NULL COMMENT '1: 획득(EARN), 2: 사용(USE)',
                         `member_id` BIGINT NOT NULL,
                         `diary_id` INT NOT NULL,
                         `calender_id` VARCHAR(255) NOT NULL,
                         `gacha_event_id` BIGINT NOT NULL,
                         `bingo_board_id` INT NOT NULL,
                         CONSTRAINT pk_point_point_id PRIMARY KEY (`point_id`)
) ENGINE=InnoDB COMMENT '포인트기록';


/* ======================================================================
   외래키 제약조건 DDL
   (명명규칙: fk_기준테이블_참조테이블)
   ====================================================================== */

ALTER TABLE `bingo_board`
    ADD CONSTRAINT fk_bingo_board_member
        FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`);

ALTER TABLE `bingo_cell`
    ADD CONSTRAINT fk_bingo_cell_bingo_board
        FOREIGN KEY (`bingo_board_id`) REFERENCES `bingo_board`(`id`);

ALTER TABLE `bingo_cell`
    ADD CONSTRAINT fk_bingo_cell_bingo_board
        FOREIGN KEY (`member_id`) REFERENCES `member`(`id`);

ALTER TABLE `bingo_fileupload`
    ADD CONSTRAINT fk_bingo_fileupload_bingo_board
        FOREIGN KEY (`bingo_cell_id`) REFERENCES `bingo_board`(`id`);

ALTER TABLE `bingo_fileupload`
    ADD CONSTRAINT fk_bingo_fileupload_bingo_board
        FOREIGN KEY (`extend_file_path_id`) REFERENCES `extend_file_path`(`id`);

ALTER TABLE `gacha_event`
    ADD CONSTRAINT fk_gacha_event_gacha_reset
        FOREIGN KEY (`event_id2`) REFERENCES `gacha_reset`(`id`);

ALTER TABLE `gacha_prize`
    ADD CONSTRAINT fk_gacha_prize_gacha_event
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`);

ALTER TABLE `gacha_quantity`
    ADD CONSTRAINT fk_gacha_quantity_gacha_prize
        FOREIGN KEY (`id`) REFERENCES `gacha_prize`(`id`);

ALTER TABLE `gacha_board_cell`
    ADD CONSTRAINT fk_gacha_board_cell_gacha_prize
        FOREIGN KEY (`gacha_prize_id`) REFERENCES `gacha_prize`(`id`);

ALTER TABLE `gacha_board_cell`
    ADD CONSTRAINT fk_gacha_board_cell_gacha_event
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`);

ALTER TABLE `gacha_board_cell`
    ADD CONSTRAINT fk_gacha_board_cell_member
        FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`);

ALTER TABLE gacha_draw_log
    ADD CONSTRAINT as_gacha_draw_log_member_id
        FOREIGN KEY (memeber_id) REFERENCES member(id)
            ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE gacha_draw_log
    ADD CONSTRAINT as_gacha_draw_log_gacha_board_cell_id
        FOREIGN KEY (gacha_board_cell_id) REFERENCES gacha_board_cell(id)
            ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE gacha_draw_log
    ADD CONSTRAINT as_gacha_draw_log_id2
        FOREIGN KEY (gacha_prize_id) REFERENCES gacha_prize(id)
            ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE gacha_reward_grant
    ADD CONSTRAINT as_gacha_reward_grant_id2
        FOREIGN KEY (gacha_prize_id) REFERENCES gacha_draw_log(id)
            ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `gacha_fileupload`
    ADD CONSTRAINT fk_gacha_fileupload_gacha_event
        FOREIGN KEY (`gacha_event_id`) REFERENCES `gacha_event`(`id`);

ALTER TABLE `gacha_fileupload`
    ADD CONSTRAINT fk_gacha_fileupload_gacha_event
        FOREIGN KEY (`extend_file_path_id`) REFERENCES `extend_file_path`(`id`);

ALTER TABLE `point`
    ADD CONSTRAINT fk_point_member
        FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`);

ALTER TABLE `point`
    ADD CONSTRAINT fk_point_member
        FOREIGN KEY (`diary_id`) REFERENCES `diary`(`diary_id`);

ALTER TABLE `point`
    ADD CONSTRAINT fk_point_member
        FOREIGN KEY (`calender_id`) REFERENCES `calender`(`calender_id`);