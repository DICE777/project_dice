package com.userchat.web.dto;

public class BoardDTO {
	
	private int boardID;
	private String userID;
	private String boardTitle;
	private String boardDate;
	
	
	public BoardDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public int getBoardID() {
		return boardID;
	}


	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}


	public String getUserID() {
		return userID;
	}


	public void setUserID(String userID) {
		this.userID = userID;
	}


	public String getBoardTitle() {
		return boardTitle;
	}


	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}


	public String getBoardDate() {
		return boardDate;
	}


	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}


	@Override
	public String toString() {
		return "BoardDTO [boardID=" + boardID + ", userID=" + userID + ", boardTitle=" + boardTitle + ", boardDate="
				+ boardDate + "]";
	}

	
	
	
}
