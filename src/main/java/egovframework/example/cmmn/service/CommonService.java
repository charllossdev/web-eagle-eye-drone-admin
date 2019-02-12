package egovframework.example.cmmn.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CommonService {

	List<EgovMap> selectAdminMenuList() throws Exception;

}
