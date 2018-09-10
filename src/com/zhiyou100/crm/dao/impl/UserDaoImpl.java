package com.zhiyou100.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.zhiyou100.crm.dao.UserDao;
import com.zhiyou100.crm.model.User;
import com.zhiyou100.crm.util.DBUtil;
import com.zhiyou100.crm.util.Pager;

public class UserDaoImpl implements UserDao {

	// 此处回顾方法重载，Java不支持参数默认值！注意区别重载（Overload）与重写（Override）！
	StringBuilder buildQuerySql(String field, String keyword) {
		return buildQuerySql(field, keyword, 0, false);
	}

	StringBuilder buildQuerySql(int id) {
		return buildQuerySql("", "", id, false);
	}

	// 把拼接SQL语句的代码封装成一个方法，避免代码重复
	StringBuilder buildQuerySql(String field, String keyword, int id, boolean isCount) {
		String filter = "";
		if (keyword != null && !"".equals(keyword)) {
			// 此处会导致SQL注入漏洞！
			filter = "and u." + field + " like '%" + keyword + "%' ";
		}

		StringBuilder sb = new StringBuilder();

		if (isCount) {
			sb.append("select count(1) from user u ");
		} else {
			sb.append("select u.*, d.department_name, r.role_name from user u ");
			sb.append("left join department d on u.department_id = d.department_id ");
			sb.append("left join role r on u.role_id = r.role_id ");
		}
		
		sb.append("where u.status = 2 ");

		if (id > 0) {
			sb.append("and u.user_id = " + id + " ");
		}

		sb.append(filter);

		return sb;
	}

	// 将填充对象的代码封装成一个方法，避免代码重复
	User fillObject(ResultSet set) throws SQLException {
		User user = new User();

		user.setUserId(set.getInt("user_id"));
		user.setUsername(set.getString("username"));
		user.setPassword(set.getString("password"));
		user.setIsAdmin(set.getBoolean("is_admin"));
		user.setIsSystem(set.getBoolean("is_system"));
		user.setDepartmentId(set.getInt("department_id"));
		user.setDepartmentName(set.getString("department_name"));
		user.setRoleId(set.getInt("role_id"));
		user.setRoleName(set.getString("role_name"));
		user.setIsMale(set.getBoolean("is_male"));
		user.setMobile(set.getString("mobile"));
		user.setAddress(set.getString("address"));
		user.setAge(set.getInt("age"));
		user.setTel(set.getString("tel"));
		user.setIdNum(set.getString("id_num"));
		user.setEmail(set.getString("email"));
		user.setQq(set.getString("qq"));
		user.setHobby(set.getString("hobby"));
		user.setEducation(set.getString("education"));
		user.setCardNum(set.getString("card_num"));
		user.setNation(set.getString("nation"));
		user.setMarry(set.getInt("marry"));
		user.setStatus(set.getInt("status"));
		user.setRemark(set.getString("remark"));
		user.setCreater(set.getInt("creater"));
		user.setCreateTime(set.getTimestamp("create_time"));
		user.setUpdater(set.getInt("updater"));
		user.setUpdateTime(set.getTimestamp("update_time"));

		return user;
	}

	@Override
	public User getUserByLogin(String username, String password) {

		// 参数化查询语句
		String sql = "select u.*, d.department_name, r.role_name from user u "
				+ "left join department d on u.department_id = d.department_id "
				+ "left join role r on u.role_id = r.role_id "
				+ "where username = ? and password = ?";
		
		User user = null;

		// 封装一个工具类，否则的话获取数据库连接的代码会出每个DaoImpl出现！
		/*
		 * Connection conn = DBUtil.getConnection(); PreparedStatement s = null;
		 * 
		 * try {
		 * 
		 * s = conn.prepareStatement(sql);
		 * 
		 * // 按顺序设置查询参数，从1开始 s.setString(1, username); s.setString(2, password);
		 * 
		 * // 查询结果 ResultSet set = s.executeQuery();
		 * 
		 * // 读取查询结果中的第一条数据 if (set.next()) { user = new User();
		 * 
		 * // 将数据设置到模型对象中 user.setUserId(set.getInt("user_id"));
		 * user.setUsername(set.getString("username"));
		 * user.setPassword(set.getString("password"));
		 * user.setIsAdmin(set.getBoolean("is_admin"));
		 * user.setStatus(set.getInt("status"));
		 * user.setCreater(set.getInt("creater"));
		 * user.setCreateTime(set.getDate("create_time"));
		 * user.setUpdater(set.getInt("updater"));
		 * user.setUpdateTime(set.getDate("update_time")); }
		 * 
		 * } catch (SQLException e) { e.printStackTrace(); } finally {
		 * 
		 * // 关闭以释放资源 try { if (s != null) s.close(); if (conn != null)
		 * conn.close(); } catch (SQLException e) { e.printStackTrace(); }
		 * 
		 * }
		 */

		// 上面创建及关闭连接和参数化语句很烦人，
		// 得先在外面声明变量，还得写finally关闭，关闭时还得判断是否为null，关闭时还有可能抛出异常！
		// 幸好 Java 7中新增了try with resources功能！可以简化代码！
		// try with resources会倒序关闭try中创建的资源
		try (Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {

			// 按顺序设置查询参数，从1开始
			s.setString(1, username);
			s.setString(2, password);

			// 查询结果
			ResultSet set = s.executeQuery();

			// 读取查询结果中的第一条数据
			if (set.next()) {
				user = this.fillObject(set);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public int total(String field, String keyword) {
		int total = 0;
		StringBuilder sb = this.buildQuerySql(field, keyword, 0, true);
		
		try(
			Connection conn = DBUtil.getConnection(); 
			PreparedStatement s = conn.prepareStatement(sb.toString());
			ResultSet set = s.executeQuery()
		){
			while (set.next()) {
				return set.getInt(1); // 注意此处从1开始！
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return total;
	}
	
	@Override
	public List<User> list(String field, String keyword, Pager pager) {
		List<User> list = new ArrayList<User>();
		
		StringBuilder sb = buildQuerySql(field, keyword);
		sb.append("limit " + (pager.getPageNo() - 1) * pager.getPageSize() + ", " + pager.getPageSize());
		
		try(
			Connection conn = DBUtil.getConnection(); 
			PreparedStatement s = conn.prepareStatement(sb.toString());
			ResultSet set = s.executeQuery()
		){
			while (set.next()) {
				User user = this.fillObject(set);
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public User getById(int userId) {
		StringBuilder sb = this.buildQuerySql(userId);
		
		try(
			Connection conn = DBUtil.getConnection(); 
			PreparedStatement s = conn.prepareStatement(sb.toString());
			ResultSet set = s.executeQuery()
		){
			if (set.next()) {
				return this.fillObject(set);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	@Override
	public boolean add(User user) {
		String sql = "INSERT INTO user (`username`, `password`, `department_id`, `role_id`, `is_male`, `mobile`, " +
				"`address`, `age`, `tel`, `id_num`, `email`, `qq`, " +
				"`hobby`, `education`, `card_num`, `nation`, `marry`, `status`, " + 
				"`remark`, `create_time`, `creater`"
				+ ") VALUES (?, ?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, ?, "
				+ "?, ?, ?)";
		
		try(Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setString(1, user.getUsername());
			s.setString(2, user.getPassword());
			s.setInt(3, user.getDepartmentId());
			s.setInt(4, user.getRoleId());
			s.setBoolean(5, user.getIsMale());
			s.setString(6, user.getMobile());
			s.setString(7, user.getAddress());
			s.setInt(8, user.getAge());
			s.setString(9, user.getTel());
			s.setString(10, user.getIdNum());
			s.setString(11, user.getEmail());
			s.setString(12, user.getQq());
			s.setString(13, user.getHobby());
			s.setString(14, user.getEducation());
			s.setString(15, user.getCardNum());
			s.setString(16, user.getNation());
			s.setInt(17, user.getMarry());
			s.setInt(18, 2);
			s.setString(19, user.getRemark());
			s.setTimestamp(20, user.getCreateTime());
			s.setInt(21, user.getCreater());
			
			

			// 增加，修改，删除都是调用executeUpdate方法
			int rowCount = s.executeUpdate();
			return rowCount > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@Override
	public boolean removeById(int userId, int updater, Timestamp updateTime) {
		// 逻辑删除
		String sql = "update user set status = -2, updater = ?, update_time = ? where user_id = ?";
		
		try(Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setInt(1, updater);
			s.setTimestamp(2, updateTime);
			s.setInt(3, userId);
			return s.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public boolean update(User user) {
		String sql = "UPDATE user SET `department_id` = ?, `role_id` = ?, `is_male` = ?, " +
				"`mobile` = ?, `address` = ?, `age` = ?, "
				+ "`tel` = ?, `id_num` = ?, `email` = ?,"
				+ "`qq` = ?, `hobby` = ?, `education` = ?,"
				+ "`card_num` = ?, `nation` = ?, `marry` = ?,"
				+ "`remark` = ?, `update_time` = ?, updater = ? "
				+ "WHERE `user_id` = ?";
		
		try(Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setInt(1, user.getDepartmentId());
			s.setInt(2, user.getRoleId());
			s.setBoolean(3, user.getIsMale());
			s.setString(4, user.getMobile());
			s.setString(5, user.getAddress());
			s.setInt(6, user.getAge());
			s.setString(7, user.getTel());
			s.setString(8, user.getIdNum());
			s.setString(9, user.getEmail());
			s.setString(10, user.getQq());
			s.setString(11, user.getHobby());
			s.setString(12, user.getEducation());
			s.setString(13, user.getCardNum());
			s.setString(14, user.getNation());
			s.setInt(15, user.getMarry());
			s.setString(16, user.getRemark());
			s.setTimestamp(17, user.getUpdateTime());
			s.setInt(18, user.getUpdater());
			s.setInt(19, user.getUserId());
			return s.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
