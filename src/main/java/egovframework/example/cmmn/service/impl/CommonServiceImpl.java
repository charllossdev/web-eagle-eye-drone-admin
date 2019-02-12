package egovframework.example.cmmn.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.cmmn.service.CommonService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CommonServiceImpl implements CommonService {
	
	@Resource
	private CommonMapper cmmnMapper;
	
	@Override
	public List<EgovMap> selectAdminMenuList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
