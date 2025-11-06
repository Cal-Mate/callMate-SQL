/* 테이블 삭제 */
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
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS comment_like;
DROP TABLE IF EXISTS post_comment;
DROP TABLE IF EXISTS post_file;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS post_tag;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS extend_file_path;

/* 테이블 생성 */
CREATE TABLE IF NOT EXISTS upload_file (
	id	bigint	NOT NULL auto_increment,
	mime_type	VARCHAR(255)	not NULL,
	file_path	VARCHAR(255)	NOT NULL,
	created_at	DATETIME	NULL default now(),
	State	VARCHAR(255)	NULL,
	original_file_name	VARCHAR(255)	NULL,
	re_file_name	VARCHAR(255)	NULL,
	member_id	bigint	NOT NULL,
	extend_fild_path_id	BIGINT	NOT NULL,
    constraint pk_upload_file_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS goal (
	id	bigint	NOT NULL auto_increment,
	type	ENUM('WEIGHT','CALORIE','MACRO') NOT NULL,
	target_value	DECIMAL(10,2)	NULL,
	kcal_per_day	INT	NULL,
	protein_g	INT	NULL,
	fat_g	INT	NULL,
	carbs_g	INT	NULL,
	start_date	DATETIME	NOT NULL,
	end_date	DATETIME	NULL,
	created_at	DATETIME	NOT NULL default now(),
	member_id	bigint	NOT NULL,
    constraint pk_goal_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ban (
	id	bigint	NOT NULL auto_increment,
	startDate	DATETIME	NOT NULL,
	endDate	DATETIME	NOT NULL,
	admin_id	bigint	NOT NULL,
	member_id	bigint	NOT NULL,
	report_no	bigint	NOT NULL,
    constraint pk_ban_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_status (
	id	bigint	NOT NULL,
	status	varchar(255)	NULL,
    constraint pk_member_status_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member (
	id	bigint	NOT NULL auto_increment,
	name	VARCHAR(255)	NULL,
	nickname	VARCHAR(255)	NULL,
	email	VARCHAR(255)	NOT NULL,
	pw	VARCHAR(255)	NOT NULL,
	phone	VARCHAR(255)	NULL,
	gender	varchar(1)	NULL,
	birth	VARCHAR(255)	NULL,
	height	DECIMAL(5,2)	NULL,
	weight	DECIMAL(5,2)	NULL,
	body_metric	INT	NULL	COMMENT '회원 가입 할때 defualt로 계산 값 입력',
	point	INT	NULL,
	created_at	DATETIME	NOT NULL default now(),
	login_failure_count	int	NULL default 0,
	login_lock_until	datetime	NULL	COMMENT '연속5회 비밀번호 오류시 15분 접속 제한',
	quit_date	datetime	NULL,
	status	bigint	NOT NULL	DEFAULT 1,
	level	bigint	NOT NULL default 1,
    constraint pk_member_id primary key(id),
    constraint ck_member_gender check(gender in('M','F'))
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_rank (
	id	bigint	NOT NULL auto_increment,
	name	varchar(255)	NULL,
	Field2	int	NULL	COMMENT '뱃지 갯수',
    constraint pk_member_rank_id primary key(id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS member_authority (
	member_id	bigint	NOT NULL ,
	authories_id	bigint	NOT NULL,
    constraint pk_member_authority_member_id_authories_id primary key(member_id,authories_id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS authorites (
	id	bigint	NOT NULL auto_increment,
	authurity	VARCHAR(255)	NOT NULL,
	description	varchar(255)	NULL,
    constraint pk_authorites_id primary key(id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS login_failure_history (
	id	bigint	NOT NULL auto_increment,
	failure_datetime	datetime	NOT NULL,
	failure_ip	varchar(255)	NULL,
	failure_reasone	varchar(2000)	NULL,
	member_id	bigint	NOT NULL,
    constraint pk_login_failure_history_id primary key(id)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS refresh_token (
	id	bigint	NOT NULL auto_increment,
	token_hash	varchar(128)	NOT NULL,
	jti	varchar(64)	NULL	COMMENT 'unique 제약조건',
	issued_at	datetime	NULL default now(),
	expires_at	datetime	NULL,
	revoked	tinyint	NULL	DEFAULT 0,
	revoked_at	datetime	NULL,
	device_fp	varchar(255)	NULL,
	ip	varchar(255)	NULL,
	last_used_at	datetime	NULL default now(),
	member_id	bigint	NOT NULL,
    constraint pk_refresh_token_id primary key(id),
    constraint uk_refresh_token_jti unique(jti)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS login_history (
	id	bigint	NOT NULL auto_increment,
	login_date	datetime	NOT NULL default now(),
	come_in_ip	varchar(255)	NULL,
	before_path	varchar(255)	NULL,
	member_id	bigint	NOT NULL,
    constraint pk_login_history_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post_like (
	id	bigint	NOT NULL auto_increment,
	like_created	DATETIME	NOT NULL default now(),
	member_id	bigint	NOT NULL,
	post_id	INT	NOT NULL,
    constraint pk_post_like_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS comment_like (
	id	bigint	NOT NULL auto_increment,
	create_at	DATETIME	NULL default now(),
	member_id	bigint	NOT NULL,
	post_comment_id	INT	NOT NULL,
    constraint pk_comment_like_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post_comment (
	id	INT	NOT NULL auto_increment,
	content	VARCHAR(255)	NOT NULL,
	create_at	DATETIME	NOT NULL default now(),
	post_id	INT	NOT NULL,
	member_id	INT	NOT NULL,
	member_parent_comment_id	INT	NULL	COMMENT '대댓글',
    constraint pk_post_comment_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS post_tag (
	id	INT	NOT NULL auto_increment,
	name	VARCHAR(255)	NULL,
	post_id	INT	NOT NULL,
    constraint pk_post_tag_id primary key(id)
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS post_file (
	id	INT	NOT NULL auto_increment,
	name	VARCHAR(255)	NULL,
	url	VARCHAR(255)	NOT NULL,
	mime_type	VARCHAR(255)	NULL,
	path	VARCHAR(255)	NOT NULL,
	created_at	DATETIME	NULL default now(),
	state	VARCHAR(255)	NULL,
	file_rename	VARCHAR(255)	NULL,
	post_id	INT	NOT NULL,
	extend_fild_path_id	INT	NOT NULL,
    url_path_id bigint null ,
    constraint pk_post_file_id primary key(id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS post (
	id	INT	NOT NULL auto_increment,
	title	VARCHAR(255)	NOT NULL,
	content	VARCHAR(255)	NULL,
	visibility	TINYINT(1)	NULL	DEFAULT 0	COMMENT '무조건 공개로 하는데 신고하면 가려지는 걸로(0:공개, 1:숨김)',
	created_at	DATETIME	NOT NULL default now(),
	member_id	bigint	NOT NULL,
	tag_id	INT	NOT NULL,
    constraint pk_post_id primary key(id)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS tag (
	id	INT	NOT NULL auto_increment	COMMENT '0:전체, 1: 내글, 2:운동, 3:식단, 4:변화, 5:자유게시판',
	name	VARCHAR(255)	NOT NULL	COMMENT '전체,내글,운동, 식단, Before&After(변화),자유게시판',
    constraint pk_tag_id primary key(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS extend_file_path (
	id	BIGINT	NOT NULL auto_increment,
	url_path	VARCHAR(255) NULL,
    constraint pk_extend_file_path_id primary key(id)
) ENGINE=InnoDB;

/* 외래키 설정 */
alter table upload_file add constraint fk_upload_file_member  foreign key(member_id)  references member(id);
alter table upload_file add constraint fk_upload_file_extend_file_path  foreign key(extend_fild_path_id)  references extend_file_path(id);
alter table goal add constraint fk_goal_member   foreign key(pk_member_status_id)  references member(id);
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
alter table post_like add constraint fk_comment_like_post   foreign key(post_id)  references post(id) ;
alter table post_like add constraint fk_comment_like_member   foreign key(member_id)  references member(id) ;
alter table post_comment add constraint fk_post_comment_post   foreign key(post_id)  references post(id);
alter table post_comment add constraint fk_post_comment_member   foreign key(member_id)  references member(id);
alter table post_comment add constraint fk_post_comment_post_comment   foreign key(member_parent_comment_id)  references post_comment (id) ;
alter table post_file add constraint fk_post_file_post   foreign key(post_id)  references post(id) ;
alter table post_file add constraint fk_post_file_extend_file_path   foreign key(url_path_id)  references extend_file_path(id);
alter table post add constraint fk_post_member   foreign key(member_id)  references member(id);
alter table post add constraint fk_post_tag   foreign key(tag_id)  references tag(id);
alter table post_tag add constraint fk_post_tag_post   foreign key(post_id)  references post(id);
alter table comment_like add constraint fk_comment_like_member   foreign key(member_id)  references member(id);
alter table comment_like add constraint fk_comment_like_post_comment   foreign key(post_comment_id)  references post_comment(id);


















