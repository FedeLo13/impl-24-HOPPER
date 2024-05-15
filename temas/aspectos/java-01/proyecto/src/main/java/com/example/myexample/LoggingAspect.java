package com.example.myexample;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.ProceedingJoinPoint;


@Aspect
class LoggingAspect {
    @Pointcut("execution(* UserManager.getCurrentUser())")
    public void accessUser() {}

    @Pointcut("execution(* UserManager.setCurrentUser(User)) || execution(* UserManager.deleteUser())")
    public void modifyUser() {}

    @Before("accessUser()")
    public void beforeAccessUser() {
        System.out.println("---------------------------------------------------------");
        System.out.println("Usted acaba de acceder a la información del usuario");
        System.out.println("---------------------------------------------------------");
    }

    @After("modifyUser()")
    public void afterModifyUser() {
        System.out.println("---------------------------------------------------------");
        System.out.println("ATENCION! USTED ACABA DE MODIFICAR INFORMACION DE USUARIO.");
        System.out.println("Puede que se haya informacion sensible. Revise.");
        System.out.println("---------------------------------------------------------");
    }

    @Around("execution(* User.setName(String)) || execution(* User.setAge(int))")
    public Object aroundUserPropertyChange(ProceedingJoinPoint pjp) throws Throwable {
        System.out.println("---------------------------------------------------------");
        System.out.println("Cambiando propiedad del usuario....");
        Object returnValue = pjp.proceed();
        System.out.println("Propiedad cambiada con éxito");
        System.out.println("---------------------------------------------------------");
        return returnValue;
    }
}