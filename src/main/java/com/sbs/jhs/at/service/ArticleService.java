package com.sbs.jhs.at.service;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.Reply;
import com.sbs.jhs.at.util.Util;

@Service
public class ArticleService {
	
	@Autowired
	private ArticleDao articleDao;
	
	/* article list 시작 */
	// 게시물 리스트
	public List<Article> getForPrintArticles(int limitFrom, int itemsInAPage) {
		
		List<Article> articles = articleDao.getForPrintArticles(limitFrom, itemsInAPage);
		
		return articles;
	}
	
	// 검색된 게시물 리스트
	public List<Article> getForPrintSearchArticle(int limitFrom, int itemsInAPage, String searchKeywordType, String searchKeyword) {
		
		List<Article> articles = articleDao.getForPrintSearchArticle(limitFrom, itemsInAPage, searchKeywordType, searchKeyword);
		
		return articles;
	}
	
	// 검색된 게시물 수 출력
	public int getForPrintListSearchArticlesCount(String searchKeywordType, String searchKeyword) {
		return articleDao.getForPrintListSearchArticlesCount(searchKeywordType, searchKeyword);
	}
	
	// 게시물 수 출력
	public int getForPrintListArticlesCount() {
		return articleDao.getForPrintListArticlesCount();
	}
	/* article list 끝 */
	
	
	/* article detail 시작 */
	// 게시물 상세보기
	public Article getForPrintArticle(int id) {
		Article article = articleDao.getForPrintArticle(id);
		
		return article;
	}
	/* article detail 끝 */
	
	
	/* article write 시작 */
	// 게시물 작성
	public int write(Map<String, Object> param) {
		
		articleDao.write(param);
		
		int id = Util.getAsInt(param.get("id"));
		
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물이 생성되었습니다.", id));

		return id;
	}
	/* article write 끝 */ 
	
	
	/* article delete 시작*/
	// 게시물 삭제
	public void delete(int id) {
		articleDao.delete(id);
	}
	/* article delete 끝*/
	
	
	/* article modify 시작*/
	// 게시물 수정
	public void modify(int id, String title, String body) {
		articleDao.modify(id, title, body);
	}
	/* article modify 끝*/
	

	

	// 댓글 작성 기능
	public Map<String, Object> writeReply(Map<String, Object> param) {
		articleDao.writeArticleReply(param);
		int id = Util.getAsInt(param.get("id"));
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 생성되었습니다.", id));

		return rs;
	}

	// 특정 게시물 댓글 수 출력
	public int getForPrintListArticleRepliesCount(int id) {
		return articleDao.getForPrintListArticleRepliesCount(id);
	}

	// 특정 게시물 내 댓글 리스트
	public List<Reply> getForPrintArticleReplies(int articleId, int from) {
		return articleDao.getForPrintArticleRepliesFrom(articleId, from);
	}

	// 특정 댓글 가져오기(수정 위함)
	public Reply getForPrintArticleReply(int articleId, int articleReplyId) {
		return articleDao.getForPrintArticleReply(articleId, articleReplyId);
	}

	// 댓글 삭제 관련
	public Map<String, Object> getArticleReplyDeleteAvailable(int id) {
		Reply articleReply = getArticleReply(id);

		Map<String, Object> rs = new HashMap<>();
		
		rs.put("resultCode", "S-1");
		rs.put("msg", "삭제권한이 있습니다.");
		
		return rs;
	}
	
	// 특정 댓글 가져오기(삭제 위함)
	public Reply getArticleReply(int id) {
		return articleDao.getArticleReply(id);
	}

	// 댓글 삭제 기능
	public Map<String, Object> deleteArticleReply(int id) {
		articleDao.deleteArticleReply(id);
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 삭제되었습니다.", id));

		return rs;
	}

	// 댓글 수정 관련
	public Map<String, Object> getArticleModifyReplyAvailable(int id) {
		Map<String, Object> rs = getArticleReplyDeleteAvailable(id);
		String msg = (String)rs.get("msg");
		msg = msg.replace("삭제", "수정");
		rs.put("msg", msg);
		
		return rs;
	}

	// 댓글 수정 기능
	public Map<String, Object> modifyReply(Map<String, Object> param) {
		articleDao.modifyArticleReply(param);
		int id = Util.getAsInt(param.get("id"));
		Map<String, Object> rs = new HashMap<>();

		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("%d번 게시물 댓글이 수정되었습니다.", id));

		return rs;
	}
	
}



