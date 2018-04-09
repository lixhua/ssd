package com.rsy.ssd.domain;


import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;

    private String name;

    private String gender;

    private Date birthday;

    private String email;

    /**
     * hibernate在5.X版本后, 如果@Column中的名字和属性名一致，会忽略掉@Column中的name属性
     * 还是属性的驼峰式命令法，将单词按照下划线拆分。
     */
    @Column(name="createTime")
    private Timestamp createTime;

    @Column(name="updateTime")
    private Timestamp updateTime;

    @ManyToOne
    @Fetch(FetchMode.SELECT)
    @JoinColumn(name="company_id", nullable = true)
    private Company company;

    public User(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
}
