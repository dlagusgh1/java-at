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
	
	// 게시물 작성 기능
	@Override
	public Map<String, Object> write(Map<String, Object> param) {
		articleDao.write(param);
		int id = CUtil.getAsInt(param.get("id"));
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물이 생성되었습니다.", id));

		return rs;
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
	public List<ArticleReply> getForPrintArticleReplies(int articleId, int from) {
		return articleDao.getForPrintArticleRepliesFrom(articleId, from);
	}
	
	// 특정 댓글 가져오기(수정 위함)
	@Override
	public ArticleReply getForPrintArticleReply(int articleId, int articleReplyId) {
		return articleDao.getForPrintArticleReply(articleId, articleReplyId);
	}

	// 댓글 삭제 관련
	@Override
	public Map<String, Object> getArticleReplyDeleteAvailable(int id) {
		ArticleReply articleReply = getArticleReply(id);

		Map<String, Object> rs = new HashMap<>();
		
		/*
		if (articleReply.getMemberId() == actorMemberId) {
			rs.put("resultCode", "S-1");
			rs.put("msg", "삭제권한이 있습니다.");
		} else {
			rs.put("resultCode", "F-1");
			rs.put("msg", "삭제권한이 없습니다.");
		}
		*/
		
		rs.put("resultCode", "S-1");
		rs.put("msg", "삭제권한이 있습니다.");
		
		return rs;
	}

	// 특정 댓글 가져오기(삭제 위함)
	public ArticleReply getArticleReply(int id) {
		return articleDao.getArticleReply(id);
	}

	// 댓글 삭제 기능
	@Override
	public Map<String, Object> deleteArticleReply(int id) {
		articleDao.deleteArticleReply(id);
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 삭제되었습니다.", id));

		return rs;
	}

	// 댓글 수정 관련
	@Override
	public Map<String, Object> getArticleModifyReplyAvailable(int id) {
		
		Map<String, Object> rs = getArticleReplyDeleteAvailable(id);
		String msg = (String)rs.get("msg");
		msg = msg.replace("삭제", "수정");
		rs.put("msg", msg);
		
		return rs;
	}

	// 댓글 수정 기능
	@Override
	public Map<String, Object> modifyReply(Map<String, Object> param) {
		articleDao.modifyArticleReply(param);
		int id = CUtil.getAsInt(param.get("id"));
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 수정되었습니다.", id));

		return rs;
	}
}
