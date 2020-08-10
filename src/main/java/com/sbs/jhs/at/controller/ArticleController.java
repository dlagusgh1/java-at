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
import com.sbs.jhs.at.dto.ArticleReply;
import com.sbs.jhs.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	// 게시물 리스트	
	@RequestMapping("article/list")
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
		
		int totalCount = articleService.getForPrintListArticlesCount();
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);
		
		List<Article> articles = articleService.getForPrintArticles(limitFrom, itemsInAPage);
		
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
	
	
	@RequestMapping("article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);

		model.addAttribute("article", article);
		
		return "article/detail";
	}
	
	// 게시물 상세보기 내 댓글 
	@RequestMapping("article/getForPrintArticleRepliesRs")
	@ResponseBody
	public Map<String, Object> getForPrintArticleRepliesRs(int id, int from) {
		
		List<ArticleReply> articleReplies = articleService.getForPrintArticleReplies(id, from);

		Map<String, Object> rs = new HashMap<>();
		
		rs.put("resultCode", "S-1");
		rs.put("msg", String.format("총 %d개의 댓글이 있습니다.", articleReplies.size()));
		rs.put("articleReplies", articleReplies);

		return rs;
	}
	
	// 게시물 작성 기능
	@RequestMapping("article/doWriteAjax")
	@ResponseBody
	public Map<String, Object> doWriteAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		Map<String, Object> rs = articleService.write(param);
		
		return rs;
	}
	
	// 게시물 삭제
	@RequestMapping("/article/delete")
	public String delete(Model model, int id) {
		
		articleService.delete(id);
		
		String redirectUrl = "/article/list?page=1";

		model.addAttribute("locationReplace", redirectUrl);

		return "common/redirect";
	}
	
	// 게시물 수정 폼
	@RequestMapping("/article/modify")
	public String modify(Model model, int id) {
		
		Article article = articleService.getForPrintArticle(id);
		
		model.addAttribute("article", article);
		
		return "article/modify";
	}
	
	// 게시물 수정 기능
	@RequestMapping("/article/doModify")
	public String doModify(Model model, int id, String title, String body) {
		
		articleService.modify(id, title, body);
		
		String redirectUrl = "/article/detail?id=" + id;

		model.addAttribute("locationReplace", redirectUrl);

		return "common/redirect";
	}
	
	// 댓글 작성 기능
	@RequestMapping("article/doWriteReplyAjax")
	@ResponseBody
	public Map<String, Object> doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		Map<String, Object> rs = articleService.writeReply(param);
		
		return rs;
	}
	
	// 댓글 삭제 기능
	@RequestMapping("article/doDeleteReplyAjax")
	@ResponseBody
	public Map<String, Object> doDeleteReplyAjax(int id, String redirectUrl, HttpServletRequest request) {
		
		Map<String, Object> articleReplyDeleteAvailableRs = articleService.getArticleReplyDeleteAvailable(id);	
		
		if (((String) articleReplyDeleteAvailableRs.get("resultCode")).startsWith("F-")) {
			return articleReplyDeleteAvailableRs;
		}

		Map<String, Object> rs = articleService.deleteArticleReply(id);
		
		/*
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		*/
		
		return rs;
	}
	
	// 댓글 수정 기능
	@RequestMapping("article/doModifyReplyAjax")
	@ResponseBody
	public Map<String, Object> doModifyReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {

		int id = Integer.parseInt((String) param.get("id"));
		
		Map<String, Object> articleModifyReplyAvailableRs = articleService.getArticleModifyReplyAvailable(id);

		if (((String) articleModifyReplyAvailableRs.get("resultCode")).startsWith("F-")) {
			return articleModifyReplyAvailableRs;
		}

		Map<String, Object> rs = articleService.modifyReply(param);

		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
	// 파일 업로드
		@RequestMapping("/article/upload")
		public String doUpload(Model model, String file) {
					
			System.out.println(file);
			
			String redirectUrl = "/article/list?page=1";

			model.addAttribute("locationReplace", redirectUrl);

			return "common/redirect";
		}
}
