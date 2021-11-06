package web.jsp04.test;
//캡슐화로 작업
public class Bean implements java.io.Serializable{

	//변수 
	private String id;
	private String pw;
	
	//매개변수 없는 기본생성자
	public Bean () {}//생략하면 자동으로 생성해서 실행
	
	
	
	
	

	
	//set get 메서드 만들기
	//각각변수의 get.set 다 있어야 한다
	
	public void setId(String id) {
		this.id=id;
	}
	public void setPw(String pw) {
		this.pw=pw;
	}
	
	public String getId() {
		return id;
	}
	
	public String getPw() {
		return pw;
	}
	
	
	
	
	
	
}
