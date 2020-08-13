package com.sbs.jhs.at.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.File;
import com.sbs.jhs.at.util.Util;

@Service
public class ArticleService {	
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private FileService fileService;
	
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
	
	// 전체 게시물 수 출력(삭제된것 포함)
	public int getForPrintListArticlesTotalCount() {
		return articleDao.getForPrintListArticlesTotalCount();
	}
	/* article list 끝 */
	
	
	/* article detail 시작 */
	// 게시물 상세보기
	public Article getForPrintArticleById(int id) {
		Article article = articleDao.getForPrintArticleById(id);
		List<File> files = fileService.getFilesMapKeyFileNo("article", article.getId(), "common", "attachment");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		if (article.getExtra() == null) {
			article.setExtra(new HashMap<>());
		}

		article.getExtra().put("file__common__attachment", filesMap);

		return article;
	}
	/* article detail 끝 */
	
	/* article write 시작 */
	// 게시물 작성
	public int write(Map<String, Object> param) {
		articleDao.write(param);
		int id = Util.getAsInt(param.get("id"));

		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}

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
	
}



