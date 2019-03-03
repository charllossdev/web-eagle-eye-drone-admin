package egovframework.example.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping(value = "/home.do")
	public String initHome() throws Exception {
		return "main/main.adminTiles";
	}
	
	@RequestMapping(value = "/Main.do")
	public String initMain() throws Exception {
		return "main/main.adminTiles";
	}
	
	@RequestMapping(value = "/UserGrade.do")
	public String initUserGrade() throws Exception {
		
		return "main/UserGrade";
	}
}
