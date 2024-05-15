package com.example.myexample;

class User {
    private String name;
    private int age;

    User(String s, int e){
        name = s;
        age = e;
    }

    String getName() { return name; }
    void setName(String name) { this.name = name; }
    int getAge() { return age; }
    void setAge(int age) { this.age = age; }
}
