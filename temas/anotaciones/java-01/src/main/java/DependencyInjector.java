package main.java;

import java.lang.reflect.Field;

public class DependencyInjector {

    public static void inject(Object object) throws IllegalAccessException, InstantiationException {
        Class<?> clazz = object.getClass();
        for (Field field : clazz.getDeclaredFields()) {
            if (field.isAnnotationPresent(CompareByDate.class)) {
                field.setAccessible(true);
                field.set(object, new OrderByDateComparator());
            } else if (field.isAnnotationPresent(CompareByAmount.class)) {
                field.setAccessible(true);
                field.set(object, new OrderByAmountComparator());
            }
        }
    }
}
