package com.sbs.jhs.at.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.Reply;
import com.sbs.jhs.at.dto.ResultData;
import com.sbs.jhs.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 게시물 리스트
	@RequestMapping("/usr/article/list")
	public String showList(Model model, String page, String searchKeywordType, String searchKeyword) {
		
		if (page == null) {
			page = "1";
		} 
		
		int Spage = Integer.parseInt(page);
		
		int itemsInAPage = 5;
		int limitFrom = (Spage-1) * itemsInAPage;
		
		if (searchKeywordType != null && searchKeyword != null) {
			List<Article> articles = articleService.getForPrintSearchArticle(limitFrom, itemsInAPage, searchKeywordType, searchKeyword);
			
			int totalCount = articleService.getForPrintListSearchArticlesCount(searchKeywordType, searchKeyword);
			int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
			
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("page", page);
			
			model.addAttribute("searchKeywordType", searchKeywordType);
			model.addAttribute("searchKeyword", searchKeyword);
			
			model.addAttribute("articles", articles);
			
			int pageCount = 5;
			int startPage = ((Spage - 1) / pageCount) * pageCount + 1;
			int endPage = startPage + pageCount - 1;
			
			if( totalPage < Spage) {
				Spage = totalPage;
			}
			if ( endPage > totalPage) {
				endPage = totalPage;
			}
			
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			
			return "article/list";
		}
		int ArticleTotalCount = articleService.getForPrintListArticlesTotalCount();
		int totalCount = articleService.getForPrintListArticlesCount();
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		
		List<Article> articles = articleService.getForPrintArticles(limitFrom, itemsInAPage);
		
		model.addAttribute("ArticleTotalCount", ArticleTotalCount);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		
		model.addAttribute("articles", articles);
		
		int pageCount = 5;
		int startPage = ((Spage - 1) / pageCount) * pageCount + 1;
		int endPage = startPage + pageCount - 1;
		
		if( totalPage < Spage) {
			Spage = totalPage;
		}
		if ( endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		

		return "article/list";
	}
	
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Article article = articleService.getForPrintArticle(id);

		model.addAttribute("article", article);
		
		return "article/detail";
	}
	
	// 게시물 작성 기능
	@RequestMapping("/usr/article/doWriteAjax")
	@ResponseBody
	public ResultData doWriteAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		Map<String, Object> rsDataBody = new HashMap<>();
		
		param.put("memberId", request.getAttribute("loginedMemberId"));
		
		int newArticleId = articleService.write(param);
		
		rsDataBody.put("id", newArticleId);

		return new ResultData("S-1", String.format("%d번 글이 생성되었습니다.", newArticleId), rsDataBody);
	}
	
	// 게시물 삭제
	@RequestMapping("/usr/article/delete")
	public String delete(Model model, int id) {
		
		articleService.delete(id);
		
		String redirectUrl = "list?page=1";

		return "redirect:" + redirectUrl;
	}
	
	// 게시물 수정 폼
	@RequestMapping("/usr/article/modify")
	public String modify(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);
		
		model.addAttribute("article", article);
		
		return "article/modify";
	}
	
	// 게시물 수정 기능
	@RequestMapping("/usr/article/doModify")
	public String doModify(Model model, int id, String title, String body) {
		
		articleService.modify(id, title, body);

		String redirectUrl = "detail?id=" + id;

		return "redirect:" + redirectUrl;
	}
	
}
