package com.example.myexample;

class UserManagerAspect {
    private User currentUser;

    User getCurrentUser() {
        return currentUser;
    }

    void setCurrentUser(User user) {
        currentUser = user;
    }

    void deleteUser() {
        currentUser = null;
    }
}
