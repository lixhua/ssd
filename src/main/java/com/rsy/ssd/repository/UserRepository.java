package com.rsy.ssd.repository;

import com.rsy.ssd.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;

public interface UserRepository extends JpaRepository<User, Integer> {

    @Modifying
    @Transactional
    @Query("delete from User where id = ?1")
    public void deleteUserById(Integer id);
}
