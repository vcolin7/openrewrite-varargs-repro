package com.original;

/**
 * This class tests that OpenRewrite can handle varargs in references in Javadoc comments.
 */
public class Original {
    /**
     * A dummy main method. This method is not actually called, but we'll use its Javadoc comment to test that
     * OpenRewrite can handle references like the following: {@link Original#main(String[])}.
     *
     * @param args The arguments to the method.
     */
    public static void main(String[] args) {
        System.out.println("Hello, world! This is my original class' main method.");
    }

    /**
     * A method that uses varargs.
     *
     * @param args The arguments to the method.
     */
    public static void varargsMethod(String... args) {
        System.out.println("Hello, world! This is my original class' varargs method.");
    }
}