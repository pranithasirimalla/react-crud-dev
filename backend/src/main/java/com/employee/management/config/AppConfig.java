package com.employee.management.config;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Application configuration class
 * Defines beans for dependency injection
 */
@Configuration
public class AppConfig {

    /**
     * ModelMapper bean for mapping between DTOs and entities
     */
    @Bean
    public ModelMapper modelMapper() {
        ModelMapper mapper = new ModelMapper();
        
        // Configure strict matching strategy to avoid conflicts
        mapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        
        return mapper;
    }
}