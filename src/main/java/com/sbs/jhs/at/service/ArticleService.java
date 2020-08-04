package com.sbs.jhs.at.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	
	// 게시물 리스트
	public List<Article> getForPrintArticles(int limitFrom, int itemsInAPage) {
		
		List<Article> articles = articleDao.getForPrintArticles(limitFrom, itemsInAPage);
		
		return articles;
	}

	// 게시물 상세보기
	public Article getForPrintArticle(int id) {		
		Article article = articleDao.getForPrintArticle(id);
	
		return article;
	}

	// 게시물 작성
	public void write(String title, String body) {
		articleDao.write(title, body);	
	}

	// 게시물 삭제
	public void delete(int id) {
		articleDao.delete(id);
	}

	// 게시물 수 출력
	public int getForPrintListArticlesCount() {
		return articleDao.getForPrintListArticlesCount();
	}

	// 게시물 수정
	public void modify(int id, String title, String body) {
		articleDao.modify(id, title, body);
	}
}



