package org.service.general.controller;

import java.util.List;

import org.service.general.entity.ServiceEntity;
import org.service.general.entity.ServiceMetaData;
import org.service.general.service.ServicesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/services")
@CrossOrigin(origins = {"http://127.0.0.1:9090","http://127.0.0.1:8080", "http://127.0.0.1"})
public class ServiceController {
	
	@Autowired
	private ServicesService service;
	
	@GetMapping("/")
	public List<ServiceEntity> getAllServices(){
		
		return service.getAllServices();
	}
	
	@GetMapping("/metadata")
	public List<ServiceMetaData> getServicesMetaData(){
		return service.getServicesMetaData();
		
	}
	

}
