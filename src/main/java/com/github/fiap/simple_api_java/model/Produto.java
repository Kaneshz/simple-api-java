package com.github.fiap.simple_api_java.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "produtos")
@Getter
@Setter
@EqualsAndHashCode(callSuper=false)
public class Produto extends AbstractEntity<Long> {

	@Column(nullable = false, length = 50, unique = true)
	private String nome;
	
}
