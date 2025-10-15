package com.github.fiap.simple_api_java.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.github.fiap.simple_api_java.model.Produto;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {
    
}
