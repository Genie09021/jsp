package web.jsp04.test;

public class FormVO {

	private String id;
	private String pw;
	private String name;
	private int age;
	
	
	public String getName() {
		return name;
	}
	
	public String getPw() {
		return pw;
	}
	public int getAge() {
		return age;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id=id;
	}
	public void setPw(String pw) {
		this.pw=pw;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setAge(int age) {
		this.age=age;
	}
	
}
