package org.service.general.service;

import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.service.general.entity.Feedback;
import org.service.general.entity.Login;
import org.service.general.entity.ProviderService;
import org.service.general.entity.Service;
import org.service.general.entity.User;
import org.service.general.repository.FeedbackRepo;
import org.service.general.repository.ProviderServiceRepo;
import org.service.general.repository.ServiceRepo;
import org.service.general.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserService {

	@Autowired
	private UserRepo repo;
	
	@Autowired
	private ProviderServiceRepo providerServiceRepo;
	
	@Autowired
	private ServiceRepo serviceRepo;
	
	@Autowired
	private FeedbackRepo feedbackRepo;
	
	private Random random = new Random();
	
	public List<User> getUsersFromService(){
		return repo.findAll();
	}

	public User getUserFromService(String username) {
		return repo.findById(username).get();
	}

	public String registerUserFromService(User user) {
		Optional<User> existing = repo.findById(user.getUsername());
		if(!existing.isPresent()) {
			repo.save(user);
			
			ProviderService ps = new ProviderService();
			ps.setUsername(user);
			Service service = serviceRepo.findByServiceName(user.getServiceType());
			ps.setServiceId(service);
			providerServiceRepo.save(ps);
			
			return "Registration is completed. Please login now.";
		} else {
			return "Oops. This username is already taken. Here is a suggestion: " + user.getUsername() + (random.nextInt(900) + 100);
		}
	}
	

	public User loginInfoFromService(Login login) {
		
		Optional<User> existing = repo.findById(login.getUsername());
		
		if(existing.isPresent()) {
			System.out.println("*********************************************************************");
			if(existing.get().getPassword().equals(login.getPassword()) && existing.get().getType().equals(login.getType())) {
				User userJson = new User(existing.get().getUsername(),existing.get().getFirstName(), existing.get().getLastName(), existing.get().getEmail(),
						null, existing.get().getAddress(), existing.get().getPhoneNumber(), existing.get().getType(), existing.get().getServiceType(), 
						null,null,null);
				return userJson;
			}
		}
/*		List<User> loginList = repo.findAll()
				.stream()
				.filter(u ->
					u.getUsername().equals(login.getUsername())
					&&
					u.getPassword().equals(login.getPassword())
					&&
					u.getType().equals(login.getType())
					)
				.collect(Collectors.toList());
				
				if(loginList.size()>0) {
					 return loginList.get(0);
					
				}
*/				return null;
		
		}

	public String feedbackInfoFromService(Feedback feedback) {
		feedbackRepo.save(feedback);
		return "Successfully submit feedback";
	}

	public String updateUserInfo(User user) {
		Optional<User> existing = repo.findById(user.getUsername());
		if(existing.isPresent()) {
			if(user.getPassword()=="") {
				user.setPassword(existing.get().getPassword());
			}
			user.setType(existing.get().getType());
			repo.save(user);
			return "Profile information is updated.";
		} else {
			return "Cannot update user information.";
		}
	}
}
