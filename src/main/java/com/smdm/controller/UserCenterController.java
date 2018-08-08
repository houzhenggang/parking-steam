package com.smdm.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.smdm.bean.Comment;
import com.smdm.bean.Lot;
import com.smdm.bean.Msg;
import com.smdm.bean.Orders;
import com.smdm.bean.User;
import com.smdm.service.CommentService;
import com.smdm.service.LotService;
import com.smdm.service.OrdersService;
import com.smdm.service.UserService;
import com.smdm.statusenum.LotEnum;
import com.smdm.statusenum.PageEnum;

/**
 * 用户个人中心
 * @author manRED
 *
 */
@RestController
@RequestMapping("/usercenter")
public class UserCenterController {
	@Autowired
	UserService userService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	LotService lotService;
	
	/**
	 * 个人中心主页面
	 * @return
	 */
	@RequestMapping("/showOrder")
	public ModelAndView showOrder(@RequestParam(value="status",defaultValue="1")int status) {
		ModelAndView mv=new ModelAndView();
		mv.addObject("status",status);
		mv.setViewName("user/showOrder");
		return mv;
	}
	
	/**
	 * 查询用户信息
	 * @param userId 用户ID
	 * @return Msg用于包装返回结果 0表示失败，1表示成功
	 */
	@GetMapping("/userinfo")
	public Msg getUser(@RequestParam("userId")int userId) {
		User user=userService.getUserInfo(userId);
		if(user==null) {
			return Msg.fail(0, "用户不存在!");
		}
		return Msg.success(1, "成功!").add("user", user);
	}
	
	/**
	 * 用户个人中心
	 * @param map
	 * @return
	 */
	@RequestMapping("/personal")
	public ModelAndView personal(Map<String,Object> map,HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		User user=userService.getUserInfo(userId);
		map.put("user", user);
		return new ModelAndView("user/personal",map);
	}
	/**
	 * 更新用户密码
	 * @param userId
	 * @param psw 原密码
	 * @param newpsw 新密码
	 * @return
	 */
	@PostMapping("/changepsw")
	public Msg changePsw(@RequestParam("psw")String psw,
						@RequestParam("newpsw")String newpsw,
						HttpServletRequest request) {
		//1.用userId查询用户信息
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		User user=userService.getUserInfo(userId);
		if(user==null) {
			return Msg.fail(0, "用户不存在!");
		}
		//2.判断用户原密码是否正确
		if(!psw.equals(user.getPassword())) {
			return Msg.fail(0, "用户原密码错误!");
		}
		//3.更新密码
		user.setPassword(newpsw);
		boolean result=userService.updateUser(user);
		if(result) {
			return Msg.success(0, "更新失败!");
		}
		return Msg.success(1, "更新成功!");
	}
	/**
	 * 修改密码页面
	 * @return
	 */
	@GetMapping("/changeMess")
	public ModelAndView changeMess() {
		return new ModelAndView("user/changeMess");
	}
	
	/**
	 * 更新车牌号、手机号
	 * @param userId
	 * @param license 车牌号
	 * @param phone 手机号
	 * @return
	 */
	@PostMapping("/updateUserInfo")
	public Msg updateUserInfo(@RequestParam("licenseNum")String licenseNum,
			@RequestParam("phone")String phone,
			HttpServletRequest request) {
		//1.用userId查询用户信息
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		User user=userService.getUserInfo(userId);
		if(user==null) {
			return Msg.fail(0, "用户不存在!");
		}
		//2.更新用户手机号、车牌号
		user.setPhone(phone);
		user.setLicenseNum(licenseNum);
		boolean result=userService.updateUser(user);
		if(result) {
			return Msg.success(0, "更新失败!");
		}
		return Msg.success(1, "更新成功!").add("user", user);
	}
	
	/**
	 * 用户订单列表
	 * @param userId 用户ID
	 * @param map 封闭数据
	 * @return
	 */
	@RequestMapping("/myOrder")
	public ModelAndView myOrder(Map<String,Object> map,HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		List<Orders> ordersList=ordersService.getOrderList(userId);
		map.put("orderList", ordersList);
		return new ModelAndView("user/myOrder",map);
	}
	/**
	 * 预约订单
	 * @param lotId
	 * @return
	 */
	@RequestMapping("/toShowOrder")
	public ModelAndView toShowOrder(@RequestParam("lotId")int lotId,HttpServletRequest request) {
		//1.查询车位信息，并将车位设置已使用
		Lot lot=lotService.getLotById(lotId).get(0);
		lot.setStatus(LotEnum.USE.getCode());
		lotService.updateLot(lot);
		
		//2.生成order订单
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		int userId=userI.getId();

		Orders order=new Orders();
		order.setLotId(lotId);
		order.setUserId(userId);
		order.setOrderTime(new Date());
		order.setPrice(lot.getPrice());
		order.setTotal(lot.getPrice());
		order.setStatus(0);
		ordersService.insertOrder(order);
		
		//3.返回页面
		ModelAndView mv=new ModelAndView();
		mv.addObject("status",PageEnum.MYORDER.getCode());
		mv.setViewName("user/showOrder");
		return mv;
	}
	
	/**
	 * 删除用户order
	 * @param orderId
	 * @return
	 */
	@RequestMapping("/deleteorder")
	public ModelAndView deleteorder(@RequestParam("orderId")int orderId,
			@RequestParam("lotId")int lotId) {
		//删除订单
		ordersService.deleteOrder(orderId);
		
		//更新车位信息
		Lot lot=lotService.getLotById(lotId).get(0);
		lot.setStatus(LotEnum.EMPTY.getCode());
		lotService.updateLot(lot);
				
		ModelAndView mv=new ModelAndView();
		mv.addObject("status",PageEnum.MYORDER.getCode());
		mv.setViewName("user/showOrder");
		return mv;
	}
	
	/**
	 * 查询用户留言列表
	 * @param userId
	 * @param map
	 * @return
	 */
	@RequestMapping("/leaveMess")
	public ModelAndView leaveMess(Map<String,Object> map,HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		List<Comment> commentlist=commentService.getCommentList(userId);
		map.put("commentlist", commentlist);
		return new ModelAndView("user/leaveMess", map);
	}
	
	/**
	 * 添加用户留言
	 * @param userId
	 * @param c
	 * @return
	 */
	@PostMapping("/docomment")
	public Msg doComment(@RequestParam("comment")String c,HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userI = (User) session.getAttribute("userObj");
		
		int userId=userI.getId();
		Comment comment=new Comment();
		comment.setComment(c);
		comment.setUserId(userId);
		comment.setComTime(new Date());
		commentService.insertComment(comment);
		return Msg.success(1, "成功");

	}
	
	/**
	 * 删除用户留言
	 * @param id
	 * @return
	 */
	@RequestMapping("/deletecomment")
	public ModelAndView deletecomment(@RequestParam("id")int id) {
		commentService.deleteComment(id);
		ModelAndView mv=new ModelAndView();
		mv.addObject("status",PageEnum.LEAVEMESS.getCode());
		mv.setViewName("user/showOrder");
		return mv;
	}
	
}
