package uca.iiss;

// creamos la anotación

import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.ElementType;
import java.util.Comparator;

@Retention(RetentionPolicy.RUNTIME) // tiempo que está presente en la compilacion
@Target(ElementType.TYPE) // elementos a los que se aplica
public @interface CompareAnnotation {
    Class<? extends Comparator<BankAccount>> compare();
}