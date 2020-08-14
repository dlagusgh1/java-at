package com.sbs.jhs.at.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.Member;
import com.sbs.jhs.at.dto.ResultData;
import com.sbs.jhs.at.service.ArticleService;
import com.sbs.jhs.at.util.Util;

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
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");

		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/detail";
	}
	
	// 게시물 작성 폼
	@RequestMapping("/usr/article/write")
	public String showWrite() {
		return "article/write";
	}
	
	// 게시물 작성 기능
	@RequestMapping("/usr/article/doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
		param.put("memberId", loginedMemberId);
		int newArticleId = articleService.write(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}
	
	// 게시물 수정 폼
	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(loginedMember, id);

		model.addAttribute("article", article);

		return "article/modify";
	}
	
	// 게시물 수정 기능
	@RequestMapping("/usr/article/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, Model model) {
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		ResultData checkActorCanModifyResultData = articleService.checkActorCanModify(loginedMember, id);
		
		if (checkActorCanModifyResultData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkActorCanModifyResultData.getMsg());
			
			return "common/redirect";
		}
		
		articleService.modify(newParam);
		
		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}
	
	// 게시물 삭제 기능
	@RequestMapping("/usr/article/doDelete")
	public String doDelete(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, Model model) {
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		ResultData checkActorCanDelteResultData = articleService.checkActorCanDelete(loginedMember, id);
		
		if (checkActorCanDelteResultData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkActorCanDelteResultData.getMsg());
			
			return "common/redirect";
		}
		
		articleService.delete(param);
		
		String redirectUri = "/usr/article/list";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s번 게시물이 삭제되었습니다.", param.get("id")));

		return "common/redirect";
	}

	
}
