package web.jsp04.test;

public class SignupFormVO {

	private String id;
	private String pw;
	private String email;
	private String gender;
	private String music;
	private String sports;
	private String travel;
	private String movies;
	private String birthYY;
	private String birthMM;
	private String birthDD;
	private String job;
	private String bio;
	
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public void setID(String id) {
		this.id=id;
		
	}
	public void setPw(String pw) {
		this.pw=pw;
		
	}
	public void setEmail(String email) {
		this.email=email;
		
	}
	public void setGender(String gender) {
		this.gender=gender;
		
	}
	public void setMusic(String music) {
		this.music=music;
		
	}
	public void setSports(String sports) {
		this.sports=sports;
		
	}
	public void setTravel(String travel) {
		this.travel=travel;
		
	}
	public void setMovies(String movies) {
		this.movies=movies;
		
	}
	
	
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getGender() {
		return gender;
	}
	
	public String getSports() {
		return sports;
	}
	public String getMusic() {
		return music;
	}
	public String getBirthMM() {
		return birthMM;
	}
	
	public String getBirthYY() {
		return birthYY;
	}
	
	public void setBirthYY(String birthYY) {
		this.birthYY = birthYY;
	}
	public String getBirthDD() {
		return birthDD;
	}
	public void setBirthDD(String birthDD) {
		this.birthDD = birthDD;
	}
	public void setBirthMM(String birthMM) {
		this.birthMM = birthMM;
	}
	public String getTravel() {
		return travel;
	}
	public String getMovies() {
		return movies;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	
	
}
