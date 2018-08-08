package com.smdm.service;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smdm.bean.User;
import com.smdm.bean.UserExample;
import com.smdm.bean.UserExample.Criteria;
import com.smdm.dao.UserMapper;

@Service
public class UserService {
	@Autowired
	UserMapper userMapper;
	
	public List<User> checkAccountPSW(String account, String password) {
		
		if(account==null || account.isEmpty() || password==null || password.isEmpty())
			return null;
		
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andAccountEqualTo(account).andPasswordEqualTo(password);
		List<User> result = userMapper.selectByExample(example);
		
		return result;
		
	}
	
	public boolean accountIsExist(String account) {
		
		if(account==null || account.isEmpty())
			return false;
		
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andAccountEqualTo(account);
		List<User> result = userMapper.selectByExample(example);
		
		if(result.size()>0)
			return true;
		else 
			return false;
	}

	public int registerUser(String account, String password,String telephone,String licenseNumber) {
		if(account==null || account.isEmpty() || password==null || password.isEmpty()|| telephone==null || telephone.isEmpty()|| licenseNumber==null || licenseNumber.isEmpty())
			return -1;
		User user = new User();
		user.setAccount(account);
		user.setPassword(password);
		user.setPhone(telephone);
		user.setLicenseNum(licenseNumber);
		user.setRegisterTime(new Date());
		int result = userMapper.insertSelective(user);
		return result;
	}
	
	/**
	 * 查询用户信息
	 * @author manRED
	 */
	public User getUserInfo(int userId) {
		User user=new User();
		user=userMapper.selectByPrimaryKey(userId);
		return user;
	}
	
	/**
	 * 更新用户信息
	 * @author manRED
	 */
	public boolean updateUser(User user) {
		int result=userMapper.updateByPrimaryKey(user);
		if(result>0) {
			return true;
		}
		return false;
	}
	
}
