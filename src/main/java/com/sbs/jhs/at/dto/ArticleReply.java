package com.sbs.jhs.at.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleReply {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private boolean delStatus;
	private boolean displayStatus;
	private int articleId;
	private String body;
}
