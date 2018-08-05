package com.userchat.web.dto;

public class ChatDTO {
	
	private int id;
	private int chatID;
	private String fromID;
	private String toID;
	private String chatContent;
	private String chatTime;
	private int goodButton;
	
	public ChatDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getChatID() {
		return chatID;
	}
	public void setChatID(int chatID) {
		this.chatID = chatID;
	}
	public String getFromID() {
		return fromID;
	}
	public void setFromID(String fromID) {
		this.fromID = fromID;
	}
	public String getToID() {
		return toID;
	}
	public void setToID(String toID) {
		this.toID = toID;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	public int getGoodButton() {
		return goodButton;
	}
	public void setGoodButton(int goodButton) {
		this.goodButton = goodButton;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "ChatDTO [id=" + id + ", chatID=" + chatID + ", fromID=" + fromID + ", toID=" + toID + ", chatContent="
				+ chatContent + ", chatTime=" + chatTime + ", goodButton=" + goodButton + "]";
	}
	
	
	
	
	
	
	
}
