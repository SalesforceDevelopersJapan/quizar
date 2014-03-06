DROP TABLE QUIZ_USER;
CREATE TABLE QUIZ_USER (
	ID SERIAL PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	TWITTER_ID BIGINT NULL,
	TWITTER_SCREEN_NAME VARCHAR(20) NULL,
	FACEBOOK_ID BIGINT NULL,
	FACEBOOK_SCREEN_NAME VARCHAR(20) NULL,
	IMAGE_URL TEXT NOT NULL,
	LAST_LOGIN TIMESTAMP NULL,
	CREATED TIMESTAMP NOT NULL,
	UPDATED TIMESTAMP NOT NULL
);

DROP TABLE QUIZ_ROOM;
CREATE TABLE QUIZ_ROOM (
	ID SERIAL PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	TAGS VARCHAR(100) NULL,
	HASHTAG VARCHAR(20) NULL,
	USER_QUIZ BOOLEAN NOT NULL DEFAULT FALSE,
	DESCRIPTION TEXT NULL,
	OWNER INT NOT NULL,
	ADMIN_USERS TEXT NULL,
	CREATED TIMESTAMP NOT NULL,
	UPDATED TIMESTAMP NOT NULL
);