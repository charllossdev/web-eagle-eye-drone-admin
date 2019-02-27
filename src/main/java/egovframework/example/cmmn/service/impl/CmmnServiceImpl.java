package egovframework.example.cmmn.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.cmmn.service.CmmnService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CmmnServiceImpl implements CmmnService {
	
	@Resource
	private CmmnMapper cmmnMapper;

	@Override
	public List<EgovMap> selectMenuList() throws Exception {

		return cmmnMapper.selectAdminMenuList();
	}

}
