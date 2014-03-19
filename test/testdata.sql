insert into quiz_user (id, name, twitter_id, twitter_screen_name, image_url, last_login, created, updated)
	values(1001, '@test_1001', 1001, '@test_1001', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1002, '@test_1002', 1002, '@test_1002', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1003, '@test_1003', 1003, '@test_1003', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1004, '@test_1004', 1004, '@test_1004', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1005, '@test_1005', 1005, '@test_1005', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1006, '@test_1006', 1006, '@test_1006', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1007, '@test_1007', 1007, '@test_1007', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1008, '@test_1008', 1008, '@test_1008', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1009, '@test_1009', 1009, '@test_1009', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
	     ,(1010, '@test_1010', 1010, '@test_1010', 'http://abs.twimg.com/sticky/default_profile_images/default_profile_4_mini.png', now(), now(), now())
;

insert into quiz_user_event (id, user_id, event_id, room_id, created, updated)
	values(1001, 1001, 2, 2, now(), now())
	     ,(1002, 1002, 2, 2, now(), now())
	     ,(1003, 1003, 2, 2, now(), now())
	     ,(1004, 1004, 2, 2, now(), now())
	     ,(1005, 1005, 2, 2, now(), now())
	     ,(1006, 1006, 2, 2, now(), now())
	     ,(1007, 1007, 2, 2, now(), now())
	     ,(1008, 1008, 2, 2, now(), now())
	     ,(1009, 1009, 2, 2, now(), now())
	     ,(1010, 1010, 2, 2, now(), now())
;

insert into quiz_user_answer (id, user_id, publish_id, event_id, user_event_id, answer, status, time, created, updated)
	values(1001, 1001, 59, 2, 1001, 1, 0, 1000, now(), now())
	     ,(1002, 1002, 59, 2, 1002, 2, 0, 1000, now(), now())
	     ,(1003, 1003, 59, 2, 1003, 3, 0, 1000, now(), now())
	     ,(1004, 1004, 59, 2, 1004, 4, 0, 1000, now(), now())
	     ,(1005, 1005, 59, 2, 1005, 5, 0, 1000, now(), now())
	     ,(1006, 1006, 59, 2, 1006, 1, 0, 1000, now(), now())
	     ,(1007, 1007, 59, 2, 1007, 2, 0, 1000, now(), now())
	     ,(1008, 1008, 59, 2, 1008, 3, 0, 1000, now(), now())
	     ,(1009, 1009, 59, 2, 1009, 4, 0, 1000, now(), now())
	     ,(1010, 1010, 59, 2, 1010, 5, 0, 1000, now(), now())
;

delete from quiz_user_answer where id > 1000;
delete from quiz_user_answer where id > 1010;
