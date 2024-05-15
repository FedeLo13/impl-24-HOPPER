package com.example.myexample;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

class UserManagerAspectTest {

    private UserManagerAspect userManagerAspect;
    private UserManager userManager;

    @BeforeEach
    void setUp() {
        userManager = new UserManager();
        userManagerAspect = new UserManagerAspect();
    }

    // Pruebas para la clase UserManager
    @Test
    void testGetCurrentUser() {
        // Arrange
        User user = new User("TestUser", 12);
        userManager.setCurrentUser(user);

        // Act
        User currentUser = userManager.getCurrentUser();

        // Assert
        assertEquals(user, currentUser, "getCurrentUser should return the current user");
    }

    @Test
    void testSetCurrentUser() {
        // Arrange
        User user = new User("TestUser", 12);

        // Act
        userManager.setCurrentUser(user);

        // Assert
        assertEquals(user, userManager.getCurrentUser(), "setCurrentUser should set the user");
    }

    @Test
    void testDeleteUser() {
        // Arrange
        User user = new User("TestUser", 12);
        userManager.setCurrentUser(user);

        // Act
        userManager.deleteUser();

        // Assert
        assertNull(userManager.getCurrentUser(), "deleteUser should set currentUser to null");
    }

    // Pruebas para el aspecto
    @Test
    void testGetCurrentUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);
        userManagerAspect.setCurrentUser(user);

        // Act
        User currentUser = userManagerAspect.getCurrentUser();

        // Assert
        assertEquals(user, currentUser, "getCurrentUser should return the current user");
    }

    @Test
    void testSetCurrentUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);

        // Act
        userManagerAspect.setCurrentUser(user); 

        // Assert
        assertEquals(user, userManagerAspect.getCurrentUser(), "setCurrentUser should set the user");
    }

    @Test
    void testDeleteUserWithAspects() {
        // Arrange
        User user = new User("TestUser", 12);
        userManagerAspect.setCurrentUser(user);

        // Act
        userManagerAspect.deleteUser();

        // Assert
        assertNull(userManagerAspect.getCurrentUser(), "deleteUser should set currentUser to null");
    }
}
