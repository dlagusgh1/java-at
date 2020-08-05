package com.sbs.jhs.at.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;
import com.sbs.jhs.at.util.CUtil;

@Service
public class ArticleServiceImpl implements ArticleService {
	@Autowired
	private ArticleDao articleDao;

	// 게시물 리스트
	@Override
	public List<Article> getForPrintArticles(int limitFrom, int itemsInAPage) {
		
		List<Article> articles = articleDao.getForPrintArticles(limitFrom, itemsInAPage);
		
		return articles;
	}

	// 게시물 상세보기
	@Override
	public Article getForPrintArticle(int id) {		
		Article article = articleDao.getForPrintArticle(id);
	
		return article;
	}

	// 게시물 작성
	@Override
	public void write(String title, String body) {
		articleDao.write(title, body);	
	}

	// 게시물 삭제
	@Override
	public void delete(int id) {
		articleDao.delete(id);
	}

	// 게시물 수 출력
	@Override
	public int getForPrintListArticlesCount() {
		return articleDao.getForPrintListArticlesCount();
	}

	// 게시물 수정
	@Override
	public void modify(int id, String title, String body) {
		articleDao.modify(id, title, body);
	}

	// 검색 게시물 리스트
	@Override
	public List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword) {
		
		List<Article> articles = articleDao.getForPrintSearchArticle(limitFrom, itemsInAPage, searchKeywordType, searchKeyword);
		
		return articles;	
	}

	// 검색 게시물 수 출력
	@Override
	public int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword) {
		return articleDao.getForPrintListSearchArticlesCount(searchKeywordType, searchKeyword);
	}

	// 댓글 작성 기능
	@Override
	public Map<String, Object> writeReply(Map<String, Object> param) {
		articleDao.writeArticleReply(param);
		int id = CUtil.getAsInt(param.get("id"));
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 생성되었습니다.", id));

		return rs;
	}

	// 특정 게시물 댓글 수 출력
	@Override
	public int getForPrintListArticleRepliesCount(int id) {
		return articleDao.getForPrintListArticleRepliesCount(id);
	}

	// 특정 게시물 내 댓글 리스트
	@Override
	public List<ArticleReply> getForPrintArticleReplies(int id, int limitFrom, int itemsInAPage) {
		
		List<ArticleReply> articleReplies = articleDao.getForPrintArticleReplies(id, limitFrom, itemsInAPage);
		
		return articleReplies;
	}

	//댓글 삭제 기능
	@Override
	public void replyDelete(int articleId, int articleReplyId) {
		articleDao.replyDelete(articleId, articleReplyId);
	}

	// 특정 댓글 가져오기(수정 위함)
	@Override
	public ArticleReply getForPrintArticleReply(int articleId, int articleReplyId) {
		return articleDao.getForPrintArticleReply(articleId, articleReplyId);
	}

	// 댓글 수정 기능
	@Override
	public void replyModify(int articleId, int articleReplyId, String body) {
		articleDao.replyModify(articleId, articleReplyId, body);
	}	
}
