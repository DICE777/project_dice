
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

DROP TABLE BOARD;

CREATE TABLE BOARD(
	boardID NUMBER PRIMARY KEY,
	userID VARCHAR2(20),
	boardTitle VARCHAR2(50),
	boardDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE board_seq;

--테스트 값--

