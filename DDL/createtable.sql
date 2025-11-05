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
	created_at	DATETIME	NOT NULL,
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
CREATE TABLE IF NOT EXISTS exercise (
	id	INT	NOT NULL 	AUTO_INCREMENT		,
	date	DATE	NULL	,
	type	VARCHAR(100)	NULL	,
	category	VARCHAR(50)	NULL	DEFAULT NULL,
	min	INT	NULL	,
	burned_kcal	INT	NULL	,
	create_at	DATETIME	NULL,
	member_id	bigint	NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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

CREATE TABLE IF NOT EXISTS diary (
	id	INT	NOT NULL	AUTO_INCREMENT	,
	day	DATETIME	NULL,
	weight	INT	NULL,
	mood	ENUM('GOOD', 'SOSO', 'BAD') NOT NULL,
	diary_condition VARCHAR(255)	NULL	,
	memo	VARCHAR(500)	NULL	,
	member_id	BIGINT	NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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

CREATE TABLE IF NOT EXISTS exercise_fileupload (
	id	INT	NOT NULL	AUTO_INCREMENT ,
	name	VARCHAR(255)	NOT NULL,
	type	VARCHAR(255)	NOT NULL,
	re_name	VARCHAR(255)	NOT NULL,
	path	VARCHAR(255)	NOT NULL,
	thumb_path	VARCHAR(255)	NULL,
	upload_order	INT	NULL,
	create_at	DATETIME	NOT NULL,
	exercise_id	INT	NOT NULL	,
	extend_fild_path_id	BIGINT	NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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
	create_at	DATETIME	NOT NULL,
	upload_order	INT	NULL,
	thumb_path	VARCHAR(255)	NULL,
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

CREATE TABLE IF NOT EXISTS report (
	id	bigint	NOT NULL	AUTO_INCREMENT	,
	title	VARCHAR(255)	NULL	,
	contents	VARCHAR(255)	NULL	,
	yn	BOOLEAN	NULL	,
	date	DATETIME	NULL	,
	report_image_url	VARCHAR(500) NULL,
	member_id2	bigint	NOT NULL	,
	post_id	INT	NOT NULL,
	comment_id	INT	NOT NULL,
	admin_id	bigint	NOT NULL,
	report_id	INT	NOT NULL	,
	member_id	bigint	NOT NULL	,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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

CREATE TABLE IF NOT EXISTS report_base (
	id	INT	NOT NULL	AUTO_INCREMENT	,
	title	VARCHAR(255)	NULL		,
	count	int	NULL		,
	day_of_ban	int	NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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
	id	BIGINT	NOT NULL 	AUTO_INCREMENT	,
	type	ENUM('BREAKFAST','LUNCH','DINNER','SNACK')	NULL,
	total_kcal	DECIMAL(8,2)	NULL,
	kcal	DECIMAL(8,2)	NULL,
	total_protein	DECIMAL(8,2)	NULL,
	total_fat	DECIMAL(8,2)	NULL,
	created_at	DATETIME	NOT NULL,
	name	VARCHAR(255)	NULL,
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

CREATE TABLE IF NOT EXISTS report_fileupload (
	id	INT	NOT NULL	AUTO_INCREMENT,
	report_id	bigint	NOT NULL,
	name	VARCHAR(255)	NOT NULL,
	type	VARCHAR(255)	NOT NULL,
	re_name	VARCHAR(255)	NOT NULL,
	path	VARCHAR(255)	NOT NULL,
	create_at	DATETIME	NOT NULL,
	thumb_path	VARCHAR(255)	NULL,
	upload_order	INT	NULL,
	extend_fild_path_id	BIGINT	NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

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

CREATE TABLE IF NOT EXISTS black_list (
	member_id	bigint	NOT NULL,
	create_date	datetime	NULL	,
	reason	varchar(2000)	NULL		,
	admin_id	bigint	NOT NULL,
	PRIMARY KEY (member_id)
) ENGINE=InnoDB;


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