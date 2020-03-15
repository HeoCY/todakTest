package java142.todak.etc.utils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Enumeration;
import java.util.List;

public class LoginSession implements HttpSessionBindingListener{
	
	private static LoginSession sManager = null;
	
	// ����� id�� ������ �� Hashtable
	private static Hashtable hashManager = new Hashtable();
	
	
	
	// ������
	private LoginSession(){
		super();
	}
	
	/**
	*
	*	�̱��� ��� 
	*
	*/
	public static synchronized LoginSession getInstance(){
		
		if(sManager == null){
			sManager = new LoginSession();
		}
		
		return sManager;
	}
	
	// �ش� ���ǿ��� �̹� �α����� �ߴ��� Ȯ�� 
	// ���Ǿ��̵� �޾Ƽ� �ش� ������ �α��� �����̸� true��, �ƴϸ� false�� ����.
	public boolean isLogin(String sessionID){
		
		boolean isLogin = false; 
		
		Enumeration e = hashManager.keys();
		String key = "";
		
		while(e.hasMoreElements()){
			
			key = (String)e.nextElement();
			
			if (sessionID.equals(key)){
				isLogin = true;
			}
		}
		
		return isLogin;
	}
	
	// �ش� ���̵��� ���� ����� �������� 
	// �̹� ������� ���̵����� Ȯ��
	// �������̵� �޾Ƽ� �ش� ������ ������ ��� ���̸� true, �ƴϸ� false�� ����.
	public boolean isUsing(String userNum)
	{
		boolean isFlag = false;
		
		Enumeration e = hashManager.keys();
		String key = "";
		
		while(e.hasMoreElements()){
			
			key = (String)e.nextElement();
			
			if (userNum.equals(hashManager.get(key))){
				isFlag = true;
			}
		}
		
		return isFlag;
	}
	
	// Hashtable�� ���Ǿ��̵� �������̵� ¦���� �ֱ�.
	//   ==> ���Ǿ��̵�� �������̵� ã�� �� �ְ���.
	// Hashtable�� ���ǿ� �ֱ�
	//   ==> ������ ���� Hashtable�� ������ �� �ְ���.
	public void setSession(HttpSession hSession, String userNum)
	{
//		System.out.println("hSession.getId() >>> " + hSession.getId());
//		System.out.println("userNum >>> " + userNum);
//		System.out.println("this.getInstance() >>> " + this.getInstance());
		List<String> container = new ArrayList<String>();
		container.add(0, "");
		container.add(1, "");
		System.out.println(" size >>> " + container.size());
		container.set(0, userNum);
		hashManager.put(hSession.getId(), container);
		hSession.setAttribute("login", this.getInstance());
	}
	
	// ������ �����Ǿ��� �� �ڵ����� ȣ��Ǵ� �޼ҵ�
	public void valueBound(HttpSessionBindingEvent event)
	{
		// nothing
	}
	
	// ������ ������ �� �ڵ����� ȣ��Ǵ� �޼ҵ�
	// ������ �������� Hashtable���� �ش� ������ ������ �����Ѵ�.
	public void valueUnbound(HttpSessionBindingEvent event)
	{
		hashManager.remove(event.getSession().getId());
	}
	
	// ���� ID�� ���� �α����� ID�� ������ ��
	public String getUserID(String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		return container.get(0);
	}
	
	// ���� ������ ��
	public int getUserCount()
	{
		return hashManager.size();
	}

	// set main menu
	public void setMain(String main, String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		container.set(1, main);

//		List<String> container2 = (List<String>)hashManager.get(sessionID);
//		System.out.println(" main IN setMain >>> " + container2.get(1));
	}

	// get main menu
	public String getMain(String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		return container.get(1);
	}
}
