DROP TABLE CHATUSER;
DROP TABLE CHAT;
DROP TABLE BOARD;
DROP SEQUENCE board_seq;

---회원 정보---

CREATE TABLE CHATUSER(
    userID VARCHAR2(20),
    userPassword VARCHAR2(20),
    userName VARCHAR2(20),
    userAge NUMBER,
    userGender VARCHAR2(20),
    userEmail VARCHAR2(50),
    userProfile VARCHAR2(50)
);


---채팅 테이블---

CREATE TABLE CHAT(
    chatID NUMBER,
    fromID VARCHAR2(20),
    toID VARCHAR2(20),
    chatContent VARCHAR(100),
    chatTime DATE
);

commit;


----게시판----

CREATE TABLE BOARD(
	boardID NUMBER PRIMARY KEY,
	userID VARCHAR2(20),
	boardTitle VARCHAR2(50),
	boardDate DATE DEFAULT SYSDATE,
	thema VARCHAR2(20) constraint board_thema_check CHECK(thema IN('종합','정치','경제','사회','문화','교육','과학/IT','역사','철학','스포츠','환경'))
);


CREATE SEQUENCE board_seq;

--테스트 값--
INSERT INTO CHATUSER(
 		userID,
	    userPassword,
	    userName,
	    userAge,
	    userGender,
	    userEmail
 	)
 	VALUES(
    'aaa','aaa','a','25','남자','aaa@naver.com'
 	);

 
 INSERT INTO CHATUSER(
 		userID,
	    userPassword,
	    userName,
	    userAge,
	    userGender,
	    userEmail
 	)
 	VALUES(
    'bbb','bbb','b','27','여자','bbb@naver.com'
 	);
	
 commit;