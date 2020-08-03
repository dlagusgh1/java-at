package com.sbs.jhs.at.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 게시물 리스트
	@RequestMapping("/article/list")
	public String showList(Model model, int page) {
			
		int itemsInAPage = 5;
		int totalCount = articleService.getForPrintListArticlesCount();
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		
		int count = articleService.getCount();
		List<Article> articles = articleService.getForPrintArticles(page, itemsInAPage);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", page);
		
		model.addAttribute("count", count);
		model.addAttribute("articles", articles);
		
		int pageCount = 5;
		int startPage = ((page - 1) / pageCount) * pageCount + 1;
		int endPage = startPage + pageCount - 1;
		
		if( totalPage < page) {
			page = totalPage;
		}
		if ( endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		return "article/list";
	}
	
	// 게시물 상세보기
	@RequestMapping("/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getOne(id);
		
		model.addAttribute("article", article);
		
		return "article/detail";
	}
	
	// 게시물 작성 폼
	@RequestMapping("/article/write")
	public String write(Model model) {
		
		return "article/write";
	}
	
	// 게시물 작성
	@RequestMapping("/article/doWrite")
	public String doWrite(Model model, String title, String body) {
		
		articleService.write(title, body);
	
		return showList(model, 1);
	}
	
	// 게시물 삭제
	@RequestMapping("/article/delete")
	public String delete(Model model, int id) {
		
		articleService.delete(id);
	
		return showList(model, 1);
	}
	
	// 게시물 수정 폼
	@RequestMapping("/article/modify")
	public String modify(Model model, int id) {
		
		Article article = articleService.getOne(id);
		
		model.addAttribute("article", article);
		
		return "article/modify";
	}
	
	// 게시물 수정 기능
	@RequestMapping("/article/doModify")
	public String doModify(Model model, int id, String title, String body) {
		
		articleService.modify(id, title, body);
	
		return showList(model, 1);
	}
}
