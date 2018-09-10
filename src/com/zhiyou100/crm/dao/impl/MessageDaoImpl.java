package com.zhiyou100.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.zhiyou100.crm.dao.MessageDao;
import com.zhiyou100.crm.model.Message;
import com.zhiyou100.crm.model.MessageSide;
import com.zhiyou100.crm.util.DBUtil;
import com.zhiyou100.crm.util.Pager;

public class MessageDaoImpl implements MessageDao {

	@Override
	public boolean update(Message message, boolean send) {
		String sql = "update message set subject = ?, content = ?, send_time = ?, "
				+ "send_delete = 2, send_status = ?, send_update_time = ?, "
				+ "receiver = ?, receive_delete = 2, receive_status = 0 where message_id = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setString(1, message.getSubject());
			s.setString(2, message.getContent());
			s.setTimestamp(3, message.getSendTime());
			s.setInt(4, message.getSendStatus());
			s.setTimestamp(5, message.getSendUpdateTime());
			s.setInt(6, message.getReceiver());
			s.setInt(7, message.getMessageId());
			return s.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean save(Message message, boolean send) {
		String sql = "insert into message (`subject`, `content`, `sender`, `save_time`, "
				+ "`send_time`, `send_delete`, `send_status`, `send_update_time`, `receiver`, "
				+ "`receive_delete`, `receive_status`) " + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setString(1, message.getSubject());
			s.setString(2, message.getContent());
			s.setInt(3, message.getSender());
			s.setTimestamp(4, message.getSaveTime());
			s.setTimestamp(5, message.getSendTime());
			s.setInt(6, 2);
			s.setInt(7, send ? 2 : 0);
			s.setTimestamp(8, message.getSendUpdateTime());
			s.setInt(9, message.getReceiver());
			s.setInt(10, 2);
			s.setInt(11, 0);
			return s.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public boolean removeById(MessageSide side, int messageId, Timestamp updateTime, boolean forever) {
		String sql;

		if (side == MessageSide.send) {
			sql = "update message set send_delete = ?, send_update_time = ? where message_id = ? ";
		} else {
			sql = "update message set receive_delete = ?, receive_update_time = ? where message_id = ? ";
		}

		try (Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setInt(1, forever ? -2 : 0);
			s.setTimestamp(2, updateTime);
			s.setInt(3, messageId);
			return s.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	Message fillObject(ResultSet set) throws SQLException {
		Message message = new Message();

		message.setMessageId(set.getInt("message_id"));
		message.setSubject(set.getString("subject"));
		message.setContent(set.getString("content"));
		message.setSender(set.getInt("sender"));
		message.setSenderName(set.getString("sender_name"));
		message.setSendDelete(set.getInt("send_delete"));
		message.setSendStatus(set.getInt("send_status"));
		message.setSaveTime(set.getTimestamp("save_time"));
		message.setSendTime(set.getTimestamp("send_time"));
		message.setSendUpdateTime(set.getTimestamp("send_update_time"));
		message.setReceiver(set.getInt("receiver"));
		message.setReceiverName(set.getString("receiver_name"));
		message.setReceiveDelete(set.getInt("receive_delete"));
		message.setReceiveStatus(set.getInt("receive_status"));
		message.setReceiveUpdateTime(set.getTimestamp("receive_update_time"));

		return message;
	}
	
	List<Message> executeList(String sql) {
		List<Message> list = new ArrayList<Message>();
		
		try(
			Connection conn = DBUtil.getConnection(); 
			PreparedStatement s = conn.prepareStatement(sql);
			ResultSet set = s.executeQuery()
		){
			while (set.next()) {
				Message message = this.fillObject(set);
				list.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	int executeTotal(String sql) {
		int total = 0;
		
		try(
			Connection conn = DBUtil.getConnection(); 
			PreparedStatement s = conn.prepareStatement(sql);
			ResultSet set = s.executeQuery()
		){
			while (set.next()) {
				return set.getInt(1); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return total;
	}

	@Override
	public Message getById(int messageId) {
		String sql = "select m.*, s.username sender_name, r.username receiver_name from message m "
				+ "left join user s on m.sender = s.user_id "
				+ "left join user r on m.receiver = r.user_id "
				+ "where m.message_id = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement s = conn.prepareStatement(sql)) {
			s.setInt(1, messageId);
			try (ResultSet set = s.executeQuery()) {
				if (set.next()) {
					return this.fillObject(set);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public int totalReceive(int userId, String field, String keyword) {
		String sql = "select count(1) from message m "
				+ "where m.receiver = " + userId + " "
				+ "and m.receive_delete = 2 ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		return this.executeTotal(sql);
	}
	
	@Override
	public List<Message> listReceive(int userId, String field, String keyword, Pager pager) {
		String sql = "select m.*, s.username sender_name, r.username receiver_name from message m "
				+ "left join user s on m.sender = s.user_id "
				+ "left join user r on m.receiver = r.user_id "
				+ "where m.receiver = " + userId + " "
				+ "and m.receive_delete = 2 ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		sql += "limit " + (pager.getPageNo() - 1) * pager.getPageSize() + ", " + pager.getPageSize();
		
		return this.executeList(sql);
	}

	@Override
	public int totalSend(int userId, String field, String keyword) {
		String sql = "select count(1) from message m "
				+ "where m.sender = " + userId + " "
				+ "and m.send_status = 2 "
				+ "and m.send_delete = 2 ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		return this.executeTotal(sql);
	}
	
	@Override
	public List<Message> listSend(int userId, String field, String keyword, Pager pager) {
		// 发件人、已发送、未删除
		String sql = "select m.*, s.username sender_name, r.username receiver_name from message m "
				+ "left join user s on m.sender = s.user_id "
				+ "left join user r on m.receiver = r.user_id "
				+ "where m.sender = " + userId + " "
				+ "and m.send_status = 2 "
				+ "and m.send_delete = 2 ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		sql += "limit " + (pager.getPageNo() - 1) * pager.getPageSize() + ", " + pager.getPageSize();
		
		return this.executeList(sql);
	}

	@Override
	public int totalRemove(int userId, String field, String keyword) {
		String sql = "select count(1) from message m "
				+ "where (m.sender = " + userId + " "
				+ "and m.send_delete = 0) or "
				+ "(m.receiver = " + userId + " "
				+ "and m.receive_delete = 0) ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		return this.executeTotal(sql);
	}
	
	@Override
	public List<Message> listRemove(int userId, String field, String keyword, Pager pager) {
		// 发件人、发件删除、收件人、收件删除
		String sql = "select m.*, s.username sender_name, r.username receiver_name from message m "
				+ "left join user s on m.sender = s.user_id "
				+ "left join user r on m.receiver = r.user_id "
				+ "where (m.sender = " + userId + " "
				+ "and m.send_delete = 0) or "
				+ "(m.receiver = " + userId + " "
				+ "and m.receive_delete = 0) ";
		
		if (keyword != null && !keyword.isEmpty()) {
			sql += "and " + field + " like '%" + keyword + "%' ";
		}
		
		sql += "limit " + (pager.getPageNo() - 1) * pager.getPageSize() + ", " + pager.getPageSize();
		
		return this.executeList(sql);
	}

	@Override
	public List<Message> listSave(int userId) {
		// 发件人、未发送、未删除
		String sql = "select m.*, s.username sender_name, r.username receiver_name from message m "
				+ "left join user s on m.sender = s.user_id "
				+ "left join user r on m.receiver = r.user_id "
				+ "where m.sender = " + userId + " "
				+ "and m.send_status = 0 "
				+ "and m.send_delete = 2 ";
		
		return this.executeList(sql);
	}

}
