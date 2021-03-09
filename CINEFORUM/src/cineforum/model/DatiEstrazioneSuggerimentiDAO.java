package cineforum.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DatiEstrazioneSuggerimentiDAO implements DAOInterfaceDoublePK<DatiEstrazioneSuggerimenti, String, Integer>{

	@Override
	public ArrayList<DatiEstrazioneSuggerimenti> retrieveAll() {
		Connection conn = null;
		PreparedStatement sql = null;
		ResultSet rs = null;
		ArrayList<DatiEstrazioneSuggerimenti> list = null;
		
		try {
			conn = DBConnectionPool.getDBConnection();
			sql = conn.prepareStatement("SELECT * FROM dati_estrazione_suggerimenti");
			rs = sql.executeQuery();
			
			list = new ArrayList<DatiEstrazioneSuggerimenti>();
			
			while(rs.next()) {
				DatiEstrazioneSuggerimenti bean = new DatiEstrazioneSuggerimenti();
				bean.setUsername(rs.getString("Username"));
				bean.setCluster(rs.getInt("Cluster"));
				bean.setNumeroEstrazione(rs.getInt("NumeroEstrazione"));
				list.add(bean);
			}
		
		}catch (SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} finally {
			DBConnectionPool.releaseConnection(conn);
			try {
				sql.close();
				rs.close();
			} catch (SQLException e) {
				System.out.println("SQLException: " + e.getMessage());
			}	
		}
		
		return list;
	}

	@Override
	public ArrayList<DatiEstrazioneSuggerimenti> retrieveAll(int option, String value) {
			return retrieveAll();
	}

	@Override
	public DatiEstrazioneSuggerimenti retrieveByKey(String username, Integer numeroCluster) {
		Connection conn = null;
		PreparedStatement sql = null;
		ResultSet rs = null;
		DatiEstrazioneSuggerimenti bean = null;
		
		try {
			conn = DBConnectionPool.getDBConnection();
			sql = conn.prepareStatement("SELECT * FROM dati_estrazione_suggerimenti WHERE Username = ? AND Cluster = ?");
			sql.setString(1, username);
			sql.setInt(2, numeroCluster);
			rs = sql.executeQuery();
			

			
			if(rs.next()) {
				bean = new DatiEstrazioneSuggerimenti();
				bean.setUsername(rs.getString("Username"));
				bean.setCluster(rs.getInt("Cluster"));
				bean.setNumeroEstrazione(rs.getInt("NumeroEstrazione"));
			}
		
		}catch (SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} finally {
			DBConnectionPool.releaseConnection(conn);
			try {
				sql.close();
				rs.close();
			} catch (SQLException e) {
				System.out.println("SQLException: " + e.getMessage());
			}	
		}
		
		return bean;
	}
	
	@Override
	public void save(DatiEstrazioneSuggerimenti bean) {
		Connection conn = null;
		PreparedStatement sql = null;
		int result = 0;
		
		try {
			conn = DBConnectionPool.getDBConnection();
			sql = conn.prepareStatement("INSERT INTO dati_estrazione_suggerimenti VALUES (?, ?, ?)");
			sql.setString(1, bean.getUsername());
			sql.setInt(2, bean.getCluster());
			sql.setInt(3, bean.getNumeroEstrazione());
			result = sql.executeUpdate();
			

			
			if(result != 0)
				conn.commit();
		
		}catch (SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} finally {
			DBConnectionPool.releaseConnection(conn);
			try {
				sql.close();
			} catch (SQLException e) {
				System.out.println("SQLException: " + e.getMessage());
			}	
		}
		
	}

	@Override
	public void update(DatiEstrazioneSuggerimenti bean) {
		Connection conn = null;
		PreparedStatement sql = null;
		int result = 0;
		
		try {
			conn = DBConnectionPool.getDBConnection();
			sql = conn.prepareStatement("UPDATE dati_estrazione_suggerimenti SET NumeroEstrazione = ? WHERE Username = ? AND Cluster = ?");
			sql.setInt(1, bean.getNumeroEstrazione());
			sql.setString(2, bean.getUsername());
			sql.setInt(3, bean.getCluster());
			result = sql.executeUpdate();
			

			
			if(result != 0)
				conn.commit();
		
		}catch (SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} finally {
			DBConnectionPool.releaseConnection(conn);
			try {
				sql.close();
			} catch (SQLException e) {
				System.out.println("SQLException: " + e.getMessage());
			}	
		}
		
	}

	@Override
	public void delete(DatiEstrazioneSuggerimenti bean) {
		Connection conn = null;
		PreparedStatement sql = null;
		int result = 0;
		
		try {
			conn = DBConnectionPool.getDBConnection();
			sql = conn.prepareStatement("DELETE FROM dati_estrazione_suggerimenti WHERE Username = ? AND Cluster = ?");
			sql.setString(1, bean.getUsername());
			sql.setInt(2, bean.getCluster());
			result = sql.executeUpdate();
			

			
			if(result != 0)
				conn.commit();
		
		}catch (SQLException e) {
			System.out.println("SQLException: " + e.getMessage());
		} finally {
			DBConnectionPool.releaseConnection(conn);
			try {
				sql.close();
			} catch (SQLException e) {
				System.out.println("SQLException: " + e.getMessage());
			}	
		}
		
	}
}
